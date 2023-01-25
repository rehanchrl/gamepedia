import Foundation
import Core
 
public struct GamesTransformer: Mapper {
    public typealias Response = [GamesList]
    public typealias Entity = [GamesListEntity]
    public typealias Domain = [GamesListDomainModel]
    
    public init() {}
    
    public func transformResponseToEntity(response: [GamesList]) -> [GamesListEntity] {
        return response.map { result in
            let newGameList = GamesListEntity()
            newGameList.id = UUID().uuidString
            newGameList.idGame = result.idGame ?? 0
            newGameList.name = result.name ?? "Unknown"
            newGameList.released = result.released ?? "Unknown"
            newGameList.backgroundImage = result.backgroundImage ?? "Unknown"
            newGameList.rating = result.rating ?? 0
            return newGameList
        }
    }
    
    public func transformEntityToDomain(entity: [GamesListEntity]) -> [GamesListDomainModel] {
        return entity.map { result in
            return GamesListDomainModel(
                id: result.id,
                idGame: result.idGame,
                name: result.name,
                released: result.released,
                backgroundImage: result.backgroundImage,
                rating: result.rating
            )
        }
    }
    
    public func transformResponseDetailToEntity(response: GameDetail) -> GameDetailEntity {
        let newGameDetail = GameDetailEntity()
        newGameDetail.id = UUID().uuidString
        newGameDetail.idGame = response.idGame ?? 0
        newGameDetail.name = response.name ?? ""
        newGameDetail.gameDescription = response.description ?? ""
        newGameDetail.released = response.released ?? ""
        newGameDetail.backgroundImage = response.backgroundImage ?? ""
        newGameDetail.rating = response.rating ?? 0
        newGameDetail.platforms = response.platforms.map{
            let newPlatformModel = PlatformsModelEntity()
            newPlatformModel.id = UUID().uuidString
            newPlatformModel.name = $0.platform?.name ?? ""
            
            return newPlatformModel
        }
        newGameDetail.genres = response.genres.map{
            let newGenreModel = GenreModelEntity()
            newGenreModel.id = UUID().uuidString
            newGenreModel.name = $0.name ?? ""
            
            return newGenreModel
        }
        
        return newGameDetail
    }
}
