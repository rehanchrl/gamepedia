//
//  GamesList.swift
//  gamepedia
//
//  Created by rehanchrl on 28/09/21.
//

import Foundation

struct GamesResponse: Codable {
    var results: [GamesList]
}

struct GamesList: Codable, Identifiable {
    let id = UUID()
    var idGame: Int?
    var name: String?
    var released: String?
    var backgroundImage: String?
    var rating: Float?
    
    enum CodingKeys: String, CodingKey {
        case name, rating, released
        case idGame = "id"
        case backgroundImage = "background_image"
    }
}
