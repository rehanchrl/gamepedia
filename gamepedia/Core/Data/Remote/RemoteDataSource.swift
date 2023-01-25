//
//  RemoteDataSource.swift
//  gamepedia
//
//  Created by rehanchrl on 08/01/23.
//

import Foundation
import Combine


protocol RemoteDataSourceProtocol: AnyObject {
//    func getGameDetail(id: Int) -> AnyPublisher<GameDetail, Error>
}

final class RemoteDataSource: NSObject {
    
    private override init() { }
    
    static let sharedInstance: RemoteDataSource =  RemoteDataSource()
    
    static let apiKey = "3bc9129cfa5446339a779e546605926a"
    static let baseURL = "https://api.rawg.io/api/"
    
}

extension RemoteDataSource: RemoteDataSourceProtocol {
    
//    func getGameDetail(id: Int) -> AnyPublisher<GameDetail, Error> {
//        return Future<GameDetail, Error> { completion in
//            guard let url = URL(string: "\(RemoteDataSource.baseURL)games/\(id)?key=\(RemoteDataSource.apiKey)") else {
//                print("Invalid url...")
//                return
//            }
//            URLSession.shared.dataTask(with: url) { data, response, error in
//                let gameDetail = try! JSONDecoder().decode(GameDetail.self, from: data!)
//                DispatchQueue.main.async {
//                    completion(.success(gameDetail))
//                }
//            }.resume()
//            
//        }.eraseToAnyPublisher()
//    }
}
