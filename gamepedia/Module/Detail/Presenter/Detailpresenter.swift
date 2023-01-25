//
//  Detailpresenter.swift
//  gamepedia
//
//  Created by rehanchrl on 11/01/23.
//

//import SwiftUI
//import Combine
//
//class DetailPresenter: ObservableObject {
//    
//    private var cancellables: Set<AnyCancellable> = []
//    private let detailUseCase: DetailUseCase
//    
//    @Published var gameDetail: GameDetailModel?
//    @Published var errorMessage: String = ""
//    @Published var loadingState: Bool = false
//    
//    init(detailUseCase: DetailUseCase) {
//        self.detailUseCase = detailUseCase
//    }
//    
//    func getGameDetail() {
//        loadingState = true
//        detailUseCase.getGameDetail()
//            .receive(on: RunLoop.main)
//            .sink(receiveCompletion: { completion in
//                switch completion {
//                case .failure:
//                    self.errorMessage = String(describing: completion)
//                case .finished:
//                    self.loadingState = false
//                }
//            }, receiveValue: { gameDetail in
//                self.gameDetail = gameDetail
//            })
//            .store(in: &cancellables)
//    }
//    
//}
