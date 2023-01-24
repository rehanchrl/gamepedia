//
//  HomePresenter.swift
//  gamepedia
//
//  Created by rehanchrl on 08/01/23.
//

import SwiftUI
import Combine

class HomePresenter: ObservableObject {
    
    private var cancellables: Set<AnyCancellable> = []
    private let router = HomeRouter()
    private let homeUseCase: HomeUseCase
    
    @Published var gameList: [GamesListModel] = []
    @Published var errorMessage: String = ""
    @Published var loadingState: Bool = false
    
    init(homeUseCase: HomeUseCase) {
        self.homeUseCase = homeUseCase
    }
    
    func getCategories(keyword: String?) {
        loadingState = true
        homeUseCase.getGamesList(keyword: keyword)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure:
                    self.errorMessage = String(describing: completion)
                case .finished:
                    self.loadingState = false
                }
            }, receiveValue: { gameList in
                self.gameList = gameList
            })
            .store(in: &cancellables)
    }
    
    func linkBuilder<Content: View>(
        for game: GamesListModel,
        @ViewBuilder content: () -> Content
    ) -> some View {
        NavigationLink(
            destination: router.makeDetailView(for: game)
        ) { content() }
    }
    
}

