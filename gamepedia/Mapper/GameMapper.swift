//
//  GameMapper.swift
//  gamepedia
//
//  Created by rehanchrl on 08/01/23.
//

import Foundation

final class GameMapper {
    
    static func mapGameListResponsesToEntities(
        input gameListResponses: [GamesList]
    ) -> [GamesListEntity] {
        return gameListResponses.map { result in
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
    
    static func mapGameListEntitiesToDomains(
        input gameListEntities: [GamesListEntity]
    ) -> [GamesListModel] {
        return gameListEntities.map { result in
            return GamesListModel(
                id: result.id,
                idGame: result.idGame,
                name: result.name,
                released: result.released,
                backgroundImage: result.backgroundImage,
                rating: result.rating
            )
        }
    }
    
    static func mapGameListResponsesToDomains(
        input gameListResponses: [GamesList]
    ) -> [GamesListModel] {
        
        return gameListResponses.map { result in
            return GamesListModel(
                id: result.id ?? "",
                idGame: result.idGame ?? 0,
                name: result.name ?? "Unknown",
                released: result.released ?? "Unknown",
                backgroundImage: result.backgroundImage ?? "Unknown",
                rating: result.rating ?? 0
            )
        }
    }
    
    static func mapGameDetailResponsesToEntities(
        input gameDetailResponse: GameDetail
    ) -> GameDetailEntity {
        let newGameDetail = GameDetailEntity()
        newGameDetail.id = UUID().uuidString
        newGameDetail.idGame = gameDetailResponse.idGame ?? 0
        newGameDetail.name = gameDetailResponse.name ?? ""
        newGameDetail.gameDescription = gameDetailResponse.description ?? ""
        newGameDetail.released = gameDetailResponse.released ?? ""
        newGameDetail.backgroundImage = gameDetailResponse.backgroundImage ?? ""
        newGameDetail.rating = gameDetailResponse.rating ?? 0
        newGameDetail.platforms = gameDetailResponse.platforms.map{
            let newPlatformModel = PlatformsModelEntity()
            newPlatformModel.id = UUID().uuidString
            newPlatformModel.name = $0.platform?.name ?? ""
            
            return newPlatformModel
        }
        newGameDetail.genres = gameDetailResponse.genres.map{
            let newGenreModel = GenreModelEntity()
            newGenreModel.id = UUID().uuidString
            newGenreModel.name = $0.name ?? ""
            
            return newGenreModel
        }
        
        return newGameDetail
    }
    
    static func mapGameDetailEntitiesToDomains(
        input gameDetailEntity: GameDetailEntity
    ) -> GameDetailModel {
        
        return GameDetailModel(
            id: gameDetailEntity.id ,
            idGame: gameDetailEntity.idGame ,
            name: gameDetailEntity.name ,
            description: gameDetailEntity.description ,
            released: gameDetailEntity.released ,
            backgroundImage: gameDetailEntity.backgroundImage ,
            rating: gameDetailEntity.rating ,
            platforms: gameDetailEntity.platforms.map {
                PlatformsModel(
                    id: $0.id,
                    name: $0.name
                )
            },
            genres: gameDetailEntity.genres.map {
                GenreModel(
                    id: $0.id,
                    name: $0.name
                )
            }
        )
    }
    
    static func mapGameDetailResponsesToDomains(
        input gameDetailResponse: GameDetail
    ) -> GameDetailModel {
        return GameDetailModel(
            id: gameDetailResponse.id ?? "",
            idGame: gameDetailResponse.idGame ?? 0,
            name: gameDetailResponse.name ?? "",
            description: gameDetailResponse.description ?? "",
            released: gameDetailResponse.released ?? "",
            backgroundImage: gameDetailResponse.backgroundImage ?? "",
            rating: gameDetailResponse.rating ?? 0,
            platforms: gameDetailResponse.platforms.map {
                PlatformsModel(
                    id: $0.id.uuidString,
                    name: $0.platform?.name ?? ""
                )
            },
            genres: gameDetailResponse.genres.map {
                GenreModel(
                    id: $0.id.uuidString,
                    name: $0.name ?? ""
                )
            }
        )
    }
    
}
