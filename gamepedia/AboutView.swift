//
//  aboutView.swift
//  gamepedia
//
//  Created by rehanchrl on 30/09/21.
//

import SwiftUI

struct AboutView: View {
    var body: some View {
        VStack {
            Image("Rehan")
                .resizable()
                .clipShape(Circle())
                .aspectRatio(contentMode: .fit)
            Text("Rehan Choirul").font(.title).bold()
            Text("I'm a Mobile Developer who loves challenges, and I am interested in new technology, have good initiatives, and have a high curiosity. I can work with a team to develop apps and solving problems together.").font(.body).multilineTextAlignment(.center)
            Spacer()
        }
        .padding()
        
        
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
    }
}
