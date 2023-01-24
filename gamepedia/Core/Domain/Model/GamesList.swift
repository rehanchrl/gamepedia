//
//  GamesList.swift
//  gamepedia
//
//  Created by rehanchrl on 28/09/21.
//

import Foundation

struct GamesListModel: Identifiable {
    var id: String
    var idGame: Int
    var name: String
    var released: String
    var backgroundImage: String
    var rating: Float
}
