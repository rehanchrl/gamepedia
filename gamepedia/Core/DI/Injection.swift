//
//  Injection.swift
//  gamepedia
//
//  Created by rehanchrl on 08/01/23.
//

import Foundation
import RealmSwift

final class Injection: NSObject {
    
    private func provideRepository() -> GameRepositoryProtocol {
        let realm = try? Realm()
        
        let locale: LocaleDataSource = LocaleDataSource.sharedInstance(realm)
        let remote: RemoteDataSource = RemoteDataSource.sharedInstance
        
        return GameRepository.sharedInstance(locale, remote)
    }
    
    func provideHome() -> HomeUseCase {
        let repository = provideRepository()
        return HomeInteractor(repository: repository)
    }
    
    func provideDetail(game: GamesListModel) -> DetailUseCase {
        let repository = provideRepository()
        return DetailInteractor(repository: repository, game: game)
    }
    
}
