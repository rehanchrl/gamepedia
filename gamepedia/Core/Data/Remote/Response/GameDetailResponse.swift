//
//  GameDetailResponse.swift
//  gamepedia
//
//  Created by rehanchrl on 11/01/23.
//

import Foundation

struct GameDetail: Codable {
    var id: String?
    var idGame: Int?
    var name: String?
    var description: String?
    var released: String?
    var backgroundImage: String?
    var rating: Float?
    var platforms: [Platforms]
    var genres: [Genre]
    
    enum CodingKeys : String, CodingKey {
        case name, description, released, rating, platforms, genres
        case idGame = "id"
        case backgroundImage = "background_image"
    }
}

struct Platforms: Codable, Identifiable {
    var id = UUID()
    var platform: Platform?
    
    enum CodingKeys: CodingKey {
        case platform
    }
}

struct Platform: Codable {
    var name: String?
}

struct Genre: Codable, Identifiable {
    var id = UUID()
    var name: String?
    
    enum CodingKeys: CodingKey {
        case name
    }
}
