//
//  ApiService.swift
//  gamepedia
//
//  Created by rehanchrl on 28/09/21.
//

import Foundation

class ApiService {
    static let apiKey = "3bc9129cfa5446339a779e546605926a"
    static let baseURL = "https://api.rawg.io/api/"
    static func getListGame(keyword: String?, completion: @escaping([GamesList]) -> ()) {
        guard let url = URL(string: "\(baseURL)games?key=\(apiKey)&search=\(keyword ?? "")") else {
            print("Invalid url...")
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            let gamesResponse = try! JSONDecoder().decode(GamesResponse.self, from: data!)
            print(gamesResponse)
            DispatchQueue.main.async {
                completion(gamesResponse.results)
            }
        }.resume()
    }
    
    static func getDetailGame(withId id: Int, completion: @escaping(GameDetail) -> ()) {
        guard let url = URL(string: "\(baseURL)games/\(id)?key=\(apiKey)") else {
            print("Invalid url...")
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            let gameDetail = try! JSONDecoder().decode(GameDetail.self, from: data!)
            print(gameDetail)
            DispatchQueue.main.async {
                completion(gameDetail)
            }
        }.resume()
    }
}
