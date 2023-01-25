//
//  DetailView.swift
//  gamepedia
//
//  Created by rehanchrl on 11/01/23.
//

import SwiftUI
import CachedAsyncImage
import Game
import Core

struct DetailView: View {
    @ObservedObject var presenter: Presenter<Any, GameDetailDomainModel, Interactor<Any,GameDetailDomainModel,GetGameDetailRepository<GetGameDetailRemoteDataSource,GameDetailTransformer>>>
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .leading) {
                HStack {
                    if #available(iOS 15.0, *) {
                        CachedAsyncImage(url: URL(string: self.presenter.item?.backgroundImage ?? "")) { image in
                            image.resizable()
                        } placeholder: {
                            ProgressView()
                        }.scaledToFit().frame(width: 100, alignment: .center).cornerRadius(10)
                    } else {
                        CustomImageView(url: self.presenter.item?.backgroundImage ?? "")
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 100)
                            .cornerRadius(10)
                    }
                    VStack(alignment: .leading) {
                        Text(self.presenter.item?.name ?? "")
                            .font(.title2)
                        Text(self.presenter.item?.released ?? "")
                            .font(.callout)
                        RatingView(rating: Int(self.presenter.item?.rating ?? 0))
                    }
                }
                Text("Platform :").font(.title3).bold()
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(alignment: .center) {
                        ForEach(Array((self.presenter.item?.platforms.enumerated() ?? [].enumerated())), id: \.offset) {_, platform in
                            
                            Text(platform.name )
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
                        ForEach(Array((self.presenter.item?.genres.enumerated() ?? [].enumerated())), id: \.offset) {_, genre in
                            
                            Text(genre.name )
                                .font(.callout)
                                .padding(3)
                                .background(Color.green)
                                .multilineTextAlignment(.center)
                            Text(" ")
                        }
                    }
                }
                Text("Description :").font(.title3).bold()
                Text(self.presenter.item?.description.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil).replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil) ?? "")
                    .font(.body)
                
                
            }.padding()
            
        }.onAppear() {
            self.presenter.execute(request: nil)
        }
    }
    
}
