import Core
import Combine
import Foundation
 
public struct GetGameDetailRemoteDataSource : DataSource {
    public typealias Request = Int
    
    public typealias Response = GameDetail
    
    private let _endpoint: String
    private let _apikey: String
    
    public init(endpoint: String, apikey: String) {
        _endpoint = endpoint
        _apikey = apikey
    }
    
    public func execute(request: Int?) -> AnyPublisher<GameDetail, Error> {
        return Future<GameDetail, Error> { completion in
            guard let url = URL(string: "\(_endpoint)/\(request ?? 0)?key=\(_apikey)") else {
                print("Invalid url...")
                return
            }
            print(">>>", url)
            URLSession.shared.dataTask(with: url) { data, response, error in
                let gameDetail = try! JSONDecoder().decode(GameDetail.self, from: data!)
                DispatchQueue.main.async {
                    completion(.success(gameDetail))
                }
            }.resume()
        }.eraseToAnyPublisher()
    }
}
