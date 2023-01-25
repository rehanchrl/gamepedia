//
//  HomeView.swift
//  gamepedia
//
//  Created by rehanchrl on 08/01/23.
//

import SwiftUI
import CachedAsyncImage
import Core
import Game

struct HomeView: View {
    
    @ObservedObject var presenter: GetListPresenter<String, GamesListDomainModel, Interactor<String, [GamesListDomainModel], GetGamesRepository<GetGamesLocaleDataSource, GetGamesRemoteDataSource, GamesTransformer>>>
    
    @State var searchText: String = ""
    
    var body: some View {
        
        List {
            TextField("Search", text: $searchText, onCommit: {
                self.presenter.getList(request: searchText)
            })
            .padding(7)
            .background(Color(.systemGray6))
            .cornerRadius(8)
            
            ForEach(self.presenter.list, id: \.id) { game in
                linkBuilder(for: game) {
                    HStack {
                        
                        if #available(iOS 15.0, *) {
                            CachedAsyncImage(url: URL(string: game.backgroundImage)) { image in
                                image.resizable()
                            } placeholder: {
                                ProgressView()
                            }.scaledToFit().frame(width: 100, alignment: .center).cornerRadius(10)
                        } else {
                            CustomImageView(url: game.backgroundImage )
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 100)
                                .cornerRadius(10)
                        }
                        VStack(alignment: .leading) {
                            Text(game.name )
                                .font(.title2)
                            Text(game.released )
                                .font(.callout)
                            RatingView(rating: Int(game.rating ))
                        }
                    }
                }
            }
        }
        .navigationTitle("Gamepedia")
        .onAppear() {
            if self.presenter.list.count == 0 {
                self.presenter.getList(request: "")
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink(destination: AboutView()) {
                    Text("About")
                }
                
            }
        }
    }
    
    func linkBuilder<Content: View>(
        for game: GamesListDomainModel,
        @ViewBuilder content: () -> Content
    ) -> some View {
        NavigationLink(
            destination: HomeRouter().makeDetailView(for: game)
        ) { content() }
    }
}
