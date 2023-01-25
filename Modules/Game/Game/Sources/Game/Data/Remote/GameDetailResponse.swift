import Foundation

public struct GameDetail: Codable {
    public var id: String?
    public var idGame: Int?
    public var name: String?
    public var description: String?
    public var released: String?
    public var backgroundImage: String?
    public var rating: Float?
    public var platforms: [Platforms]
    public var genres: [Genre]
    
    enum CodingKeys : String, CodingKey {
        case name, description, released, rating, platforms, genres
        case idGame = "id"
        case backgroundImage = "background_image"
    }
}

public struct Platforms: Codable, Identifiable {
    public var id = UUID()
    public var platform: Platform?
    
    enum CodingKeys: CodingKey {
        case platform
    }
}

public struct Platform: Codable {
    public var name: String?
}

public struct Genre: Codable, Identifiable {
    public var id = UUID()
    public var name: String?
    
    enum CodingKeys: CodingKey {
        case name
    }
}
