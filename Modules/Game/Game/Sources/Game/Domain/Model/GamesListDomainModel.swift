import Foundation

public struct GamesListDomainModel: Identifiable {
    public var id: String
    public var idGame: Int
    public var name: String
    public var released: String
    public var backgroundImage: String
    public var rating: Float
}
