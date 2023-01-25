//
//  DetailInteractor.swift
//  gamepedia
//
//  Created by rehanchrl on 08/01/23.
//

//import Combine
//import Game
//
//protocol DetailUseCase {
//    
//    func getGameDetail() -> AnyPublisher<GameDetailModel, Error>
//    
//}
//
//class DetailInteractor: DetailUseCase {
//    
//    private let repository: GameRepositoryProtocol
//    private let game: GamesListDomainModel
//    
//    required init(
//        repository: GameRepositoryProtocol,
//        game: GamesListDomainModel
//    ) {
//        self.repository = repository
//        self.game = game
//    }
//    
//    func getGameDetail() -> AnyPublisher<GameDetailModel, Error> {
//        return repository.getGameDetail(id: game.idGame)
//    }
//    
//}
