//
//  ContentView.swift
//  gamepedia
//
//  Created by rehanchrl on 28/09/21.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    @State var searchText: String = ""
    @State var games:[GamesList] = []
    
    
    var maxRating = 5
    var offImage: Image?
    var onImage = Image(systemName: "star.fill")
    
    var offColor = Color.gray
    var onColor = Color.yellow
    
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
    
    func image(for number: Int, rating: Int) -> Image {
        if number > rating {
            return offImage ?? onImage
        } else {
            return onImage
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
