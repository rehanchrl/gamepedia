import Foundation
import RealmSwift

public class GamesListEntity: Object {
    
    @objc dynamic var id: String = ""
    @objc dynamic var idGame: Int = 0
    @objc dynamic var name: String = ""
    @objc dynamic var released: String = ""
    @objc dynamic var backgroundImage: String = ""
    @objc dynamic var rating: Float = 0
    
    public override static func primaryKey() -> String? {
        return "id"
    }
}
