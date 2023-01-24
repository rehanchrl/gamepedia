//
//  LocaleDataSource.swift
//  gamepedia
//
//  Created by rehanchrl on 08/01/23.
//

import Foundation
import RealmSwift
import Combine

protocol LocaleDataSourceProtocol: AnyObject {
    
    func getGamesList() -> AnyPublisher<[GamesListEntity], Error>
    func addGamesList(from categories: [GamesListEntity]) -> AnyPublisher<Bool, Error>
    
}

final class LocaleDataSource: NSObject {
    
    private let realm: Realm?
    
    private init(realm: Realm?) {
        self.realm = realm
    }
    
    static let sharedInstance: (Realm?) -> LocaleDataSource = { realmDatabase in
        return LocaleDataSource(realm: realmDatabase)
    }
    
}

extension LocaleDataSource: LocaleDataSourceProtocol {
    
    func getGamesList() -> AnyPublisher<[GamesListEntity], Error> {
        return Future<[GamesListEntity], Error> { completion in
            if let realm = self.realm {
                let gameList: Results<GamesListEntity> = {
                    realm.objects(GamesListEntity.self)
                }()
                completion(.success(gameList.toArray(ofType: GamesListEntity.self)))
            } else {
                completion(.failure(DatabaseError.invalidInstance))
            }
        }.eraseToAnyPublisher()
    }
    
    func addGamesList(
        from categories: [GamesListEntity]
    ) -> AnyPublisher<Bool, Error> {
        return Future<Bool, Error> { completion in
            if let realm = self.realm {
                do {
                    try realm.write {
                        for category in categories {
                            realm.add(category, update: .all)
                        }
                        completion(.success(true))
                    }
                } catch {
                    completion(.failure(DatabaseError.requestFailed))
                }
            } else {
                completion(.failure(DatabaseError.invalidInstance))
            }
        }.eraseToAnyPublisher()
    }
    
}

extension Results {
    
    func toArray<T>(ofType: T.Type) -> [T] {
        var array = [T]()
        for index in 0 ..< count {
            if let result = self[index] as? T {
                array.append(result)
            }
        }
        return array
    }
    
}
