//
//  ContentView.swift
//  Starwars
//
//  Created by Ron Tabachnik on 2023-11-16.
//

import SwiftUI

struct MainScreen: View {
    @ObservedObject var dataManager = DataManager()
//    @State private var favorite: Character?
    @State private var searchText: String = ""

    var body: some View {
        VStack {
            SearchBar(onSearch: {
                dataManager.performRequest(searchText: searchText)
            }, text: $searchText)
            .environmentObject(dataManager)
            Spacer()
            if !dataManager.characters.isEmpty || !dataManager.searchedResult.isEmpty {
                ScrollView {
                    LazyVStack {
                        let charactersToDisplay = dataManager.searchedResult.isEmpty || searchText.isEmpty ? dataManager.characters : dataManager.searchedResult

                        ForEach(charactersToDisplay, id: \.id) { character in
                            CharacterCellView(
                                character: character,
                                isFavorite: Binding(
                                    get: { dataManager.favorite == character.name },
                                    set: { isFavorite in
                                        dataManager.favorite = isFavorite ? character.name : nil
                                    }
                                )
                            )
                            .onAppear {
                                if character.id == charactersToDisplay.last?.id && dataManager.hasNextPage != nil && !dataManager.loading {
                                    dataManager.performRequest(urlString: dataManager.hasNextPage ?? "")
                                    print(dataManager.hasNextPage ?? "")
                                }
                            }
                        }
                    }
                }

                if let nextPage = dataManager.hasNextPage {
                    if dataManager.loading {
                        ProgressView("Loading...")
                    }
                }
            } else {
                if dataManager.loading {
                    ProgressView("Loading...")
                } else {
                    Text("No data to show..")
                }
            }
        }
        .padding()
        .onAppear {
            dataManager.performRequest()
        }
    }
}



#Preview {
    MainScreen()
}
