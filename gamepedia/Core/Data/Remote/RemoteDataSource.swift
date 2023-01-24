//
//  RemoteDataSource.swift
//  gamepedia
//
//  Created by rehanchrl on 08/01/23.
//

import Foundation
import Combine

protocol RemoteDataSourceProtocol: AnyObject {
    
    func getGamesList(keyword: String?) -> AnyPublisher<[GamesList], Error>
    func getGameDetail(id: Int) -> AnyPublisher<GameDetail, Error>
}

final class RemoteDataSource: NSObject {
    
    private override init() { }
    
    static let sharedInstance: RemoteDataSource =  RemoteDataSource()
    
    static let apiKey = "3bc9129cfa5446339a779e546605926a"
    static let baseURL = "https://api.rawg.io/api/"
    
}

extension RemoteDataSource: RemoteDataSourceProtocol {
    
    func getGamesList(keyword: String?) -> AnyPublisher<[GamesList], Error> {
        return Future<[GamesList], Error> { completion in
            guard let url = URL(string: "\(RemoteDataSource.baseURL)games?key=\(RemoteDataSource.apiKey)&search=\(keyword ?? "")") else {
                completion(.failure(URLError.invalidResponse))
                return
            }
            URLSession.shared.dataTask(with: url) { data, response, error in
                if error != nil {
                    completion(.failure("unreachable" as! Error))
                } else if let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200 {
                    let decoder = JSONDecoder()
                    do {
                        let games = try decoder.decode(GamesResponse.self, from: data)
                        print(games.results.count)
                        DispatchQueue.main.async {
                            completion(.success(games.results))
                        }
                        
                    } catch {
                        completion(.failure("invalid" as! Error))
                    }
                }
            }.resume()
            
        }.eraseToAnyPublisher()
    }
    
    func getGameDetail(id: Int) -> AnyPublisher<GameDetail, Error> {
        return Future<GameDetail, Error> { completion in
            guard let url = URL(string: "\(RemoteDataSource.baseURL)games/\(id)?key=\(RemoteDataSource.apiKey)") else {
                print("Invalid url...")
                return
            }
            URLSession.shared.dataTask(with: url) { data, response, error in
                let gameDetail = try! JSONDecoder().decode(GameDetail.self, from: data!)
                DispatchQueue.main.async {
                    completion(.success(gameDetail))
                }
            }.resume()
            
        }.eraseToAnyPublisher()
    }
}
