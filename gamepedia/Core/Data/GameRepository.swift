//
//  GameRepository.swift
//  gamepedia
//
//  Created by rehanchrl on 08/01/23.
//

import Foundation
import Combine

protocol GameRepositoryProtocol {
    
    func getGamesList(keyword: String?) -> AnyPublisher<[GamesListModel], Error>
    func getGameDetail(id: Int) -> AnyPublisher<GameDetailModel, Error>
    
}

final class GameRepository: NSObject {
    
    typealias GameInstance = (LocaleDataSource, RemoteDataSource) -> GameRepository
    
    fileprivate let remote: RemoteDataSource
    fileprivate let locale: LocaleDataSource
    
    private init(locale: LocaleDataSource, remote: RemoteDataSource) {
        self.locale = locale
        self.remote = remote
    }
    
    static let sharedInstance: GameInstance = { localeRepo, remoteRepo in
        return GameRepository(locale: localeRepo, remote: remoteRepo)
    }
    
}

extension GameRepository: GameRepositoryProtocol {
    
    func getGamesList(keyword: String?) -> AnyPublisher<[GamesListModel], Error> {
        return self.locale.getGamesList()
            .flatMap { result -> AnyPublisher<[GamesListModel], Error> in
                if result.isEmpty {
                    return self.remote.getGamesList(keyword: keyword)
                        .map { GameMapper.mapGameListResponsesToEntities(input: $0) }
                        .flatMap { self.locale.addGamesList(from: $0) }
                        .filter { $0 }
                        .flatMap { _ in self.locale.getGamesList()
                                .map { GameMapper.mapGameListEntitiesToDomains(input: $0) }
                        }
                        .eraseToAnyPublisher()
                } else {
                    return self.locale.getGamesList()
                        .map { GameMapper.mapGameListEntitiesToDomains(input: $0) }
                        .eraseToAnyPublisher()
                }
            }.eraseToAnyPublisher()
    }
    
    func getGameDetail(id: Int) -> AnyPublisher<GameDetailModel, Error> {
        return self.remote.getGameDetail(id: id)
            .map { GameMapper.mapGameDetailResponsesToDomains(input: $0)
            }.eraseToAnyPublisher()
    }
    
}

