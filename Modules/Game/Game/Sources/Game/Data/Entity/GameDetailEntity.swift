import Foundation
import RealmSwift

public class GameDetailEntity: Object {
    
    @objc dynamic var id: String = ""
    @objc dynamic var idGame: Int = 0
    @objc dynamic var name: String = ""
    @objc dynamic var gameDescription: String = ""
    @objc dynamic var released: String = ""
    @objc dynamic var backgroundImage: String = ""
    @objc dynamic var rating: Float = 0
    public var platforms: [PlatformsModelEntity] = []
    public var genres: [GenreModelEntity] = []
    
    
    public override static func primaryKey() -> String? {
        return "id"
    }
}

public class PlatformsModelEntity: Object {
    @objc dynamic var id: String = ""
    @objc dynamic var name: String = ""
    
    public override static func primaryKey() -> String? {
        return "id"
    }
}

public class GenreModelEntity: Object {
    @objc dynamic var id: String = ""
    @objc dynamic var name: String = ""
    
    public override static func primaryKey() -> String? {
        return "id"
    }
}
