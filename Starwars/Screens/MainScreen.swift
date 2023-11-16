//
//  ContentView.swift
//  Starwars
//
//  Created by Ron Tabachnik on 2023-11-16.
//

import SwiftUI

struct MainScreen: View {
    @ObservedObject var dataManager = DataManager()
    @State private var favorite: Character?

    var body: some View {
        VStack {
            if !dataManager.characters.isEmpty {
                ScrollView {
                    LazyVStack {
                        ForEach(dataManager.characters, id: \.id) { character in
                            CharacterCellView(
                                character: character,
                                isFavorite: Binding(
                                    get: { self.favorite == character },
                                    set: { isFavorite in
                                        self.favorite = isFavorite ? character : nil
                                    }
                                )
                            )
                            .onAppear {
                                if character.id == dataManager.characters.last?.id && dataManager.hasNextPage != nil && !dataManager.loading {
                                    dataManager.performRequest(urlString: dataManager.hasNextPage ?? "")
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
