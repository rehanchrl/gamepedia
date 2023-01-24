//
//  RatingView.swift
//  gamepedia
//
//  Created by rehanchrl on 30/09/21.
//

import SwiftUI

struct RatingView: View {
    var rating = 0
    var maxRating = 5
    var offImage: Image?
    var onImage = Image(systemName: "star.fill")
    
    var offColor = Color.gray
    var onColor = Color.yellow
    
    var body: some View {
        HStack {
            ForEach(1..<maxRating + 1) { number in
                self.image(for: number, rating: rating)
                    .foregroundColor(number > rating ? self.offColor : self.onColor)
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

struct RatingView_Previews: PreviewProvider {
    static var previews: some View {
        RatingView()
    }
}
