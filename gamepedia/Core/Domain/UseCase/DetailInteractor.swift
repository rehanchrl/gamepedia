//
//  DetailInteractor.swift
//  gamepedia
//
//  Created by rehanchrl on 08/01/23.
//

import Combine

protocol DetailUseCase {
    
    func getGameDetail() -> AnyPublisher<GameDetailModel, Error>
    
}

class DetailInteractor: DetailUseCase {
    
    private let repository: GameRepositoryProtocol
    private let game: GamesListModel
    
    required init(
        repository: GameRepositoryProtocol,
        game: GamesListModel
    ) {
        self.repository = repository
        self.game = game
    }
    
    func getGameDetail() -> AnyPublisher<GameDetailModel, Error> {
        return repository.getGameDetail(id: game.idGame)
    }
    
}
