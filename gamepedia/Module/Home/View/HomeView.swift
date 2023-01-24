//
//  HomeView.swift
//  gamepedia
//
//  Created by rehanchrl on 08/01/23.
//

import SwiftUI
import CachedAsyncImage

struct HomeView: View {
    
    @ObservedObject var presenter: HomePresenter
    
    @State var searchText: String = ""
    
    var body: some View {
        
        List {
            TextField("Search", text: $searchText, onCommit: {
                self.presenter.getCategories(keyword: searchText)
            })
            .padding(7)
            .background(Color(.systemGray6))
            .cornerRadius(8)
            
            ForEach(self.presenter.gameList, id: \.idGame) { game in
                self.presenter.linkBuilder(for: game) {
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
            if self.presenter.gameList.count == 0 {
                self.presenter.getCategories(keyword: "")
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
    
}
