import Core
import Combine
import RealmSwift
import Foundation


public struct GetGamesLocaleDataSource: LocaleDataSource {
    
    public typealias Request = Any
    public typealias Response = GamesListEntity
    
    private let _realm: Realm
    
    public init(realm: Realm) {
        _realm = realm
    }
    
    public func list(request: Any?) -> AnyPublisher<[GamesListEntity], Error> {
        return Future<[GamesListEntity], Error> { completion in
            let categories: Results<GamesListEntity> = {
              _realm.objects(GamesListEntity.self)
            }()
            completion(.success(categories.toArray(ofType: GamesListEntity.self)))
          
        }.eraseToAnyPublisher()
    }
 
 
    public func add(entities: [GamesListEntity]) -> AnyPublisher<Bool, Error> {
        return Future<Bool, Error> { completion in
            do {
                try _realm.write {
                    for category in entities {
                        _realm.add(category, update: .all)
                    }
                    completion(.success(true))
                }
            } catch {
                completion(.failure(DatabaseError.requestFailed))
            }
            
        }.eraseToAnyPublisher()
    }
    
    public func get(id: String) -> AnyPublisher<GamesListEntity, Error> {
        fatalError()
    }
    
    public func update(id: Int, entity: GamesListEntity) -> AnyPublisher<Bool, Error> {
        fatalError()
    }
}
