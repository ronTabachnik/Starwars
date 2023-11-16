//
//  DataManager.swift
//  Starwars
//
//  Created by Ron Tabachnik on 2023-11-16.
//

import Foundation

class DataManager: ObservableObject {
    @Published var characters: [Character] = []
    @Published var searchedResult: [Character] = []
    @Published var loading: Bool = false
    @Published var isError: Bool = false
    @Published var hasNextPage: String? = nil
    @Published var favorite: String?

    private let baseURLString = "https://swapi.dev/api/people/"
    
    func performRequest(urlString: String = "",searchText: String = "") {
        loading = true
        isError = false
        guard let url = URL(string: searchText.isEmpty ? urlString == "" ? "\(baseURLString)" : urlString : "\(baseURLString)?search=\(searchText)") else {
            requestFailure()
            return
        }
        
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            guard let self = self else { return }
            
            guard error == nil else {
                self.requestFailure()
                return
            }
            
            if let data = data {
                do {
                    let response = try JSONDecoder().decode(Payload.self, from: data)
                    DispatchQueue.main.async {
                        guard let nextPage = response.next else {
                            self.isError = false
                            self.hasNextPage = nil
                            self.loading = false
                            if searchText.isEmpty {
                                self.characters.sort(by: { (Int($0.height) ?? 0) < (Int($1.height) ?? 0) })
                            } else {
                                self.searchedResult = response.results
                            }
                            return
                        }
                        
                        guard !response.results.isEmpty else {
                            self.isError = true
                            self.hasNextPage = nil
                            self.loading = false
                            return
                        }
                        self.loading = false
                        self.hasNextPage = nextPage
                        if searchText.isEmpty {
                            self.characters += response.results
                        } else {
                            self.searchedResult = response.results
                        }
                        
                        self.isError = false
                    }
                } catch {
                    DispatchQueue.main.async {
                        self.requestFailure()
                    }
                }

            } else {
                self.requestFailure()
            }
        }.resume()
    }

    
    private func requestFailure() {
        loading = false
        isError = true
    }
}
