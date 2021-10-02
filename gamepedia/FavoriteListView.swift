//
//  FavoriteListView.swift
//  gamepedia
//
//  Created by rehanchrl on 03/10/21.
//

import SwiftUI

struct FavoriteListView: View {
    
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @FetchRequest(entity: Game.entity(), sortDescriptors: []) var favorites: FetchedResults<Game>
    
    var body: some View {
        NavigationView {
            List {
                ForEach(favorites) { game in
                    NavigationLink(destination:
                                    DetailView(game:
                                                GamesList(
                                                    idGame: Int(game.idGame),
                                                    name: game.name,
                                                    released: game.released,
                                                    backgroundImage: game.backgroundImage,
                                                    rating: game.rating))
                    ) {
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
                                RatingView(rating: Int(game.rating))
                            }
                            Spacer()
                            Button {
                                deleteFavorite(gameId: Int(game.idGame ))
                            } label: {
                                Image(systemName: "heart.fill").foregroundColor(.pink)
                            }.buttonStyle(PlainButtonStyle())
                            
                        }
                    }
                    
                }
            }
            .navigationTitle("Favorite")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: AboutView()) {
                        Text("About")
                    }
                    
                }
            }
        }
    }
    
    func deleteFavorite(gameId: Int) {
        if let favorite = favorites.filter({ $0.idGame == gameId }).first {
            managedObjectContext.delete(favorite)
        }

        PersistenceController.shared.save()
    }
}

struct FavoriteListView_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteListView()
    }
}
