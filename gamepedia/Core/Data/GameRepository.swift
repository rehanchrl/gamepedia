////
////  GameRepository.swift
////  gamepedia
////
////  Created by rehanchrl on 08/01/23.
////
//
//import Foundation
//import Combine
//
//protocol GameRepositoryProtocol {
//    
//    func getGameDetail(id: Int) -> AnyPublisher<GameDetailModel, Error>
//    
//}
//
//final class GameRepository: NSObject {
//    
//    typealias GameInstance = (LocaleDataSource, RemoteDataSource) -> GameRepository
//    
//    fileprivate let remote: RemoteDataSource
//    fileprivate let locale: LocaleDataSource
//    
//    private init(locale: LocaleDataSource, remote: RemoteDataSource) {
//        self.locale = locale
//        self.remote = remote
//    }
//    
//    static let sharedInstance: GameInstance = { localeRepo, remoteRepo in
//        return GameRepository(locale: localeRepo, remote: remoteRepo)
//    }
//    
//}
//
//extension GameRepository: GameRepositoryProtocol {
//    
//    func getGameDetail(id: Int) -> AnyPublisher<GameDetailModel, Error> {
//        return self.remote.getGameDetail(id: id)
//            .map { GameMapper.mapGameDetailResponsesToDomains(input: $0)
//            }.eraseToAnyPublisher()
//    }
//    
//}
//
