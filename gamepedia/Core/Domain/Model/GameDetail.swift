//
//  GameDetail.swift
//  gamepedia
//
//  Created by rehanchrl on 28/09/21.
//

import Foundation

struct GameDetailModel: Identifiable {
    var id: String
    var idGame: Int
    var name: String
    var description: String
    var released: String
    var backgroundImage: String
    var rating: Float
    var platforms: [PlatformsModel]
    var genres: [GenreModel]
}

struct PlatformsModel: Identifiable {
    var id: String
    var name: String
}

struct GenreModel: Identifiable {
    var id: String
    var name: String
}
