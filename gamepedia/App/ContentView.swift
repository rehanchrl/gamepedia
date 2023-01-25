//
//  ContentView.swift
//  gamepedia
//
//  Created by rehanchrl on 28/09/21.
//

import SwiftUI
import CoreData
import Core
import Game

struct ContentView: View {
    @EnvironmentObject var homePresenter: GetListPresenter<String, GamesListDomainModel, Interactor<String, [GamesListDomainModel], GetGamesRepository<GetGamesLocaleDataSource, GetGamesRemoteDataSource, GamesTransformer>>>
    
    @State var games:[GamesList] = []
    
    var body: some View {
        NavigationView {
            HomeView(presenter: homePresenter)
        }
    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
