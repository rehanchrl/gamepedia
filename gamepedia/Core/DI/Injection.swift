//
//  Injection.swift
//  gamepedia
//
//  Created by rehanchrl on 08/01/23.
//

import UIKit
import RealmSwift
import Core
import Game


final class Injection: NSObject {
    
    private let realm = try? Realm()
    
    func provideHome<U: UseCase>() -> U where U.Request == String, U.Response == [GamesListDomainModel] {
            
        let locale = GetGamesLocaleDataSource(realm: realm!)
        
        let remote = GetGamesRemoteDataSource(endpoint: "https://api.rawg.io/api/games", apikey: "3bc9129cfa5446339a779e546605926a")
        
        let mapper = GamesTransformer()
        
        let repository = GetGamesRepository(
            localeDataSource: locale,
            remoteDataSource: remote,
            mapper: mapper)
        
        return Interactor(repository: repository) as! U
    }
    
    func provideDetail<U: UseCase>(game: GamesListDomainModel) -> U where U.Request == Any, U.Response == GameDetailDomainModel {
        
        let remote = GetGameDetailRemoteDataSource(endpoint: "https://api.rawg.io/api/games", apikey: "3bc9129cfa5446339a779e546605926a")
        
        let mapper = GameDetailTransformer()
        
        let repository = GetGameDetailRepository(
            game: game,
            remoteDataSource: remote,
            mapper: mapper
        )
        
        return Interactor(repository: repository) as! U
    }
    
}
