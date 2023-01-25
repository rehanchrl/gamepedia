import Foundation

public struct GamesResponse: Codable {
    var results: [GamesList]
}

public struct GamesList: Codable, Identifiable {
    public var id: String?
    public var idGame: Int?
    public var name: String?
    public var released: String?
    public var backgroundImage: String?
    public var rating: Float?
    
    enum CodingKeys: String, CodingKey {
        case name, rating, released
        case idGame = "id"
        case backgroundImage = "background_image"
    }
}
