//
//  StarwarsModel.swift
//  Starwars
//
//  Created by Ron Tabachnik on 2023-11-16.
//

import Foundation

// MARK: - Payload
struct Payload: Codable,Equatable {
    let count: Int
    let next: String?
    let previous: String?
    let results: [Character]
}

// MARK: - Result
struct Character: Codable,Equatable {
    let id = UUID()
    let name: String
    let height: String
    let mass: String
    let hairColor: String
    let skinColor: String
    let eyeColor: String
    let birthYear: String
    let gender: Gender
    let homeworld: String
    let films: [String]
    let species: [String]
    let vehicles: [String]
    let starships: [String]
    let created: String
    let edited: String
    let url: String

    enum CodingKeys: String, CodingKey {
        case name, height, mass
        case hairColor = "hair_color"
        case skinColor = "skin_color"
        case eyeColor = "eye_color"
        case birthYear = "birth_year"
        case gender
        case homeworld
        case films
        case species
        case vehicles
        case starships
        case created
        case edited
        case url
    }
    static var test1: Character {
        Character(
                name: "Luke Skywalker",
                height: "172",
                mass: "77",
                hairColor: "blond",
                skinColor: "fair",
                eyeColor: "blue",
                birthYear: "19BBY",
                gender: .male,
                homeworld: "https://swapi.dev/api/planets/1/",
                films: [
                    "https://swapi.dev/api/films/1/",
                    "https://swapi.dev/api/films/2/",
                    "https://swapi.dev/api/films/3/",
                    "https://swapi.dev/api/films/6/"
                ],
                species: [],
                vehicles: [
                    "https://swapi.dev/api/vehicles/14/",
                    "https://swapi.dev/api/vehicles/30/"
                ],
                starships: [
                    "https://swapi.dev/api/starships/12/",
                    "https://swapi.dev/api/starships/22/"
                ],
                created: "2014-12-09T13:50:51.644000Z",
                edited: "2014-12-20T21:17:56.891000Z",
                url: "https://swapi.dev/api/people/1/"
            )
        }
}

enum Gender: String, Codable {
    case female = "female"
    case male = "male"
    case nA = "n/a"
    case hermaphrodite = "hermaphrodite"
    case none = "none"
}
