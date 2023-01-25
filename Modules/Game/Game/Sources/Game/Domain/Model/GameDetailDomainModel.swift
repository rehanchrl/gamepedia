import Foundation

public struct GameDetailDomainModel: Identifiable {
    public var id: String
    public var idGame: Int
    public var name: String
    public var description: String
    public var released: String
    public var backgroundImage: String
    public var rating: Float
    public var platforms: [PlatformsModel]
    public var genres: [GenreModel]
}

public struct PlatformsModel: Identifiable {
    public var id: String
    public var name: String
}

public struct GenreModel: Identifiable {
    public var id: String
    public var name: String
}
