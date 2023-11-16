//
//  SearchBarView.swift
//  Starwars
//
//  Created by Ron Tabachnik on 2023-11-16.
//

import SwiftUI

struct SearchBar: View {
    var onSearch: () -> Void
    @State var showClear = false
    @Binding var text: String
    @EnvironmentObject var dataManager: DataManager
    
    var body: some View {
        HStack {
            TextField("Search...", text: $text, onEditingChanged: { _ in
                showClear = true
            }, onCommit: {
                onSearch()
            })
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .padding(.horizontal)
            if showClear {
                Button(action: {
                    text = ""
                    showClear = false
                    dataManager.searchedResult = []
                }) {
                    Text("Clear")
                }
                .padding(.horizontal)
            }
            Button(action: {
                onSearch()
            }) {
                Text("Search")
            }
            .padding(.trailing)
        }
    }
}
