//
//  HomeRouter.swift
//  gamepedia
//
//  Created by rehanchrl on 08/01/23.
//

import SwiftUI

class HomeRouter {
    
    func makeDetailView(for game: GamesListModel) -> some View {
        let detailUseCase = Injection.init().provideDetail(game: game)
        let presenter = DetailPresenter(detailUseCase: detailUseCase)
        return DetailView(presenter: presenter)
    }
    
}
