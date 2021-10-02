//
//  ContentView.swift
//  gamepedia
//
//  Created by rehanchrl on 28/09/21.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @FetchRequest(entity: Game.entity(), sortDescriptors: []) var favorites: FetchedResults<Game>
    @State var searchText: String = ""
    @State var games:[GamesList] = []
    
    var body: some View {
        NavigationView {
            List {
                TextField("Search", text: $searchText, onCommit: {
                    ApiService.getListGame(keyword: searchText) { games in
                        self.games = games
                    }
                })
                .padding(7)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                
                ForEach(games) { game in
                    NavigationLink(destination: DetailView(game: game)) {
                        HStack {
                            CustomImageView(url: game.backgroundImage ?? "")
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 100)
                                .cornerRadius(10)
                            VStack(alignment: .leading) {
                                Text(game.name ?? "")
                                    .font(.title2)
                                Text(game.released ?? "")
                                    .font(.callout)
                                RatingView(rating: Int(game.rating ?? 0))
                            }
                            Spacer()
                            Button {
                                if isFavorited(game) {
                                    deleteFavorite(game)
                                } else {
                                    saveToFavorite(game)
                                }
                                
                            } label: {
                                Image(systemName: isFavorited(game) ? "heart.fill" : "heart" ).foregroundColor(.pink)
                            }.buttonStyle(PlainButtonStyle())

                        }
                    }
                    
                }
            }
            .navigationTitle("Gamepedia")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: AboutView()) {
                        Text("About")
                    }

                }
            }
        }
        .onAppear() {
            ApiService.getListGame(keyword: "") { games in
                self.games = games
            }
        }
        
    }
    
    func isFavorited(_ game: GamesList) -> Bool {
        if favorites.filter({ $0.idGame == game.idGame ?? 0 }).isEmpty {
            return false
        }
        return true
    }
    
    func saveToFavorite(_ game: GamesList) {
        let favoriteGame = Game(context: managedObjectContext)
        favoriteGame.idGame = Int32(game.idGame ?? 0)
        favoriteGame.name = game.name
        favoriteGame.backgroundImage = game.backgroundImage
        favoriteGame.released = game.released
        favoriteGame.rating = game.rating ?? 0
        
        PersistenceController.shared.save()
    }
    
    func deleteFavorite(_ game: GamesList) {
        if let favorite = favorites.filter({ $0.idGame == game.idGame ?? 0 }).first {
            managedObjectContext.delete(favorite)
        }
        
        PersistenceController.shared.save()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
