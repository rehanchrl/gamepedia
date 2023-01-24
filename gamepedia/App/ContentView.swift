//
//  ContentView.swift
//  gamepedia
//
//  Created by rehanchrl on 28/09/21.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @EnvironmentObject var homePresenter: HomePresenter
    
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
