//
//  HomeInteractor.swift
//  gamepedia
//
//  Created by rehanchrl on 08/01/23.
//

import Foundation
import Combine

protocol HomeUseCase {
    
    func getGamesList(keyword: String?) -> AnyPublisher<[GamesListModel], Error>
    
}

class HomeInteractor: HomeUseCase {
    
    private let repository: GameRepositoryProtocol
    
    required init(repository: GameRepositoryProtocol) {
        self.repository = repository
    }
    
    func getGamesList(keyword: String?) -> AnyPublisher<[GamesListModel], Error> {
        return repository.getGamesList(keyword: keyword)
    }
    
}
