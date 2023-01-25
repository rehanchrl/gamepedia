//
//  gamepediaApp.swift
//  gamepedia
//
//  Created by rehanchrl on 28/09/21.
//

import SwiftUI
import Core
import Game

let injection = Injection()

let gameUseCase: Interactor<
  String,
  [GamesListDomainModel],
  GetGamesRepository<
    GetGamesLocaleDataSource,
    GetGamesRemoteDataSource,
    GamesTransformer>
> = injection.provideHome()

@main
struct gamepediaApp: App {
    
    let homePresenter = GetListPresenter(useCase: gameUseCase)
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(homePresenter)
        }
    }
}
