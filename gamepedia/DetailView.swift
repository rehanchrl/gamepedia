//
//  DetailView.swift
//  gamepedia
//
//  Created by rehanchrl on 29/09/21.
//

import SwiftUI

struct DetailView: View {
    var game: GamesList
    
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @FetchRequest(entity: Game.entity(), sortDescriptors: []) var favorites: FetchedResults<Game>
    
    @State var gameDetail: GameDetail?
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .leading) {
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
                        if isFavorited() {
                            deleteFavorite()
                        } else {
                            saveToFavorite()
                        }
                        
                    } label: {
                        Image(systemName: isFavorited() ? "heart.fill" : "heart" ).foregroundColor(.pink)
                    }.buttonStyle(PlainButtonStyle())
                }
                Text("Platform :").font(.title3).bold()
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(alignment: .center) {
                        ForEach(Array((gameDetail?.platforms.enumerated() ?? [].enumerated())), id: \.offset) {_, platform in
                            
                            Text(platform.platform?.name ?? "")
                                .font(.callout)
                                .frame(width: 90, height: 80)
                                .background(Color.green)
                                .multilineTextAlignment(.center)
                        }
                    }
                }
                Text("Genre :").font(.title3).bold()
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 0) {
                        ForEach(Array((gameDetail?.genres.enumerated() ?? [].enumerated())), id: \.offset) {_, genre in
                            
                            Text(genre.name ?? "")
                                .font(.callout)
                                .padding(3)
                                .background(Color.green)
                                .multilineTextAlignment(.center)
                            Text(" ")
                        }
                    }
                }
                Text("Description :").font(.title3).bold()
                Text(gameDetail?.description?.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil).replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil) ?? "")
                    .font(.body)
                
                
            }.padding()
            
        }.onAppear() {
            ApiService.getDetailGame(withId: game.idGame ?? 0) { gameDetail in
                self.gameDetail = gameDetail
            }
        }
    }
    
    func isFavorited() -> Bool {
        if favorites.filter({ $0.idGame == game.idGame ?? 0 }).isEmpty {
            return false
        }
        return true
    }
    
    func saveToFavorite() {
        let favoriteGame = Game(context: managedObjectContext)
        favoriteGame.idGame = Int32(gameDetail?.idGame ?? 0)
        favoriteGame.name = gameDetail?.name
        favoriteGame.backgroundImage = gameDetail?.backgroundImage
        favoriteGame.released = gameDetail?.released
        favoriteGame.rating = gameDetail?.rating ?? 0
        
        PersistenceController.shared.save()
    }
    
    func deleteFavorite() {
        if let favorite = favorites.filter({ $0.idGame == game.idGame ?? 0 }).first {
            managedObjectContext.delete(favorite)
        }
        
        PersistenceController.shared.save()
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(game: GamesList(idGame: 1, name: "Test", released: "12-12-1212", backgroundImage: "", rating: 5.0))
    }
}
