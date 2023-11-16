//
//  CharacterCellView.swift
//  Starwars
//
//  Created by Ron Tabachnik on 2023-11-16.
//

import SwiftUI

struct CharacterCellView: View {
    let character: Character
    @Binding var isFavorite: Bool

    var body: some View {
        HStack(alignment: .center) {
            Image(systemName: isFavorite ? "heart.fill" : "heart")
                .foregroundColor(.red)
                .padding(.trailing)
                .onTapGesture {
                    withAnimation {
                        isFavorite.toggle()
                    }
                }

            VStack(alignment: .leading) {
                Text(character.name)
                    .font(.headline)
                    .foregroundColor(.accentColor)
                    .minimumScaleFactor(0.5)
                    .padding(.trailing, 20)

                Text(character.gender.rawValue)
                    .lineLimit(1)
                    .minimumScaleFactor(0.5)
                    .font(.caption)
            }

            Spacer()

            Text("Height: \(character.height)")
                .lineLimit(1)
                .font(.footnote)
                .minimumScaleFactor(0.5)
        }
        .frame(height: CGFloat(Int(character.height) ?? 30))
        .padding()
        .background(isFavorite ? Color.blue.opacity(0.1) : Color.gray.opacity(0.1))
        .cornerRadius(10)
    }
}


#Preview {
    CharacterCellView(character: Character.test1, isFavorite: Binding<Bool>.constant(true))
}
