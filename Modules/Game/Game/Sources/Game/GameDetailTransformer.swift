import Foundation
import Core
 
public struct GameDetailTransformer: Mapper {
    public typealias Response = GameDetail
    public typealias Entity = GameDetailEntity
    public typealias Domain = GameDetailDomainModel
    
    public init() {}
    
    public func transformResponseToEntity(response: GameDetail) -> GameDetailEntity {
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
    
    public func transformEntityToDomain(entity: GameDetailEntity) -> GameDetailDomainModel {
        return GameDetailDomainModel(
            id: entity.id ,
            idGame: entity.idGame ,
            name: entity.name ,
            description: entity.description ,
            released: entity.released ,
            backgroundImage: entity.backgroundImage ,
            rating: entity.rating ,
            platforms: entity.platforms.map {
                PlatformsModel(
                    id: $0.id,
                    name: $0.name
                )
            },
            genres: entity.genres.map {
                GenreModel(
                    id: $0.id,
                    name: $0.name
                )
            }
        )
    }
}
