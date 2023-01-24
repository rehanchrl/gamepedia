//
//  GameDetailEntity.swift
//  gamepedia
//
//  Created by rehanchrl on 11/01/23.
//

import Foundation
import RealmSwift

class GameDetailEntity: Object {
    
    @objc dynamic var id: String = ""
    @objc dynamic var idGame: Int = 0
    @objc dynamic var name: String = ""
    @objc dynamic var gameDescription: String = ""
    @objc dynamic var released: String = ""
    @objc dynamic var backgroundImage: String = ""
    @objc dynamic var rating: Float = 0
    var platforms: [PlatformsModelEntity] = []
    var genres: [GenreModelEntity] = []
    
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

class PlatformsModelEntity: Object {
    @objc dynamic var id: String = ""
    @objc dynamic var name: String = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

class GenreModelEntity: Object {
    @objc dynamic var id: String = ""
    @objc dynamic var name: String = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
