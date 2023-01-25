import Core
import Combine
import Foundation
 
public struct GetGamesRemoteDataSource : DataSource {
    public typealias Request = String
    
    public typealias Response = [GamesList]
    
    private let _endpoint: String
    private let _apikey: String
    
    public init(endpoint: String, apikey: String) {
        _endpoint = endpoint
        _apikey = apikey
    }
    
    public func execute(request: String?) -> AnyPublisher<[GamesList], Error> {
        return Future<[GamesList], Error> { completion in
            guard let url = URL(string: "\(_endpoint)?key=\(_apikey)&search=\(request ?? "")") else {
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
}
