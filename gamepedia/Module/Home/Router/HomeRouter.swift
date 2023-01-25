//
//  HomeRouter.swift
//  gamepedia
//
//  Created by rehanchrl on 08/01/23.
//

import SwiftUI
import Game
import Core

class HomeRouter {
    
    
    
    func makeDetailView(for game: GamesListDomainModel) -> some View {
        let detailUseCase: Interactor<Any,GameDetailDomainModel,GetGameDetailRepository<GetGameDetailRemoteDataSource,GameDetailTransformer>> = Injection.init().provideDetail(game: game)
//        let detailUseCase = Injection.init().provideDetail(game: game)
        let presenter = Presenter(useCase: detailUseCase)
        return DetailView(presenter: presenter)
    }
    
}
