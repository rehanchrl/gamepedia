import Core
import Combine

public struct GetGamesRepository<
    GamesLocaleDataSource: LocaleDataSource,
    RemoteDataSource: DataSource,
    Transformer: Mapper>: Repository
where
    GamesLocaleDataSource.Response == GamesListEntity,
    RemoteDataSource.Response == [GamesList],
    Transformer.Response == [GamesList],
    Transformer.Entity == [GamesListEntity],
    Transformer.Domain == [GamesListDomainModel] {

    public typealias Request = String
    public typealias Response = [GamesListDomainModel]
    
    private let _localeDataSource: GamesLocaleDataSource
    private let _remoteDataSource: RemoteDataSource
    private let _mapper: Transformer
    
    public init(
        localeDataSource: GamesLocaleDataSource,
        remoteDataSource: RemoteDataSource,
        mapper: Transformer) {
        
        _localeDataSource = localeDataSource
        _remoteDataSource = remoteDataSource
        _mapper = mapper
    }
    
    public func execute(request: String?) -> AnyPublisher<[GamesListDomainModel], Error> {
        return _localeDataSource.list(request: nil)
          .flatMap { result -> AnyPublisher<[GamesListDomainModel], Error> in
            if result.isEmpty {
                return _remoteDataSource.execute(request: request as? RemoteDataSource.Request)
                .map { _mapper.transformResponseToEntity(response: $0) }
                .catch { _ in _localeDataSource.list(request: nil) }
                .flatMap { _localeDataSource.add(entities: $0) }
                .filter { $0 }
                .flatMap { _ in _localeDataSource.list(request: nil)
                  .map { _mapper.transformEntityToDomain(entity: $0) }
                }
                .eraseToAnyPublisher()
            } else {
              return _localeDataSource.list(request: nil)
                .map { _mapper.transformEntityToDomain(entity: $0) }
                .eraseToAnyPublisher()
            }
          }.eraseToAnyPublisher()
    }
}
