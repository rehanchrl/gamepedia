//
//  GamesListEntity.swift
//  gamepedia
//
//  Created by rehanchrl on 08/01/23.
//

import Foundation
import RealmSwift

class GamesListEntity: Object {
    
    @objc dynamic var id: String = ""
    @objc dynamic var idGame: Int = 0
    @objc dynamic var name: String = ""
    @objc dynamic var released: String = ""
    @objc dynamic var backgroundImage: String = ""
    @objc dynamic var rating: Float = 0
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
