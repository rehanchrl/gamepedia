import Core
import Combine

public struct GetGameDetailRepository<
    RemoteDataSource: DataSource,
    Transformer: Mapper>: Repository
where
    RemoteDataSource.Response == GameDetail,
    Transformer.Response == GameDetail,
    Transformer.Entity == GameDetailEntity,
    Transformer.Domain == GameDetailDomainModel {

    public typealias Request = Any
    public typealias Response = GameDetailDomainModel
    
    private let _game: GamesListDomainModel
    private let _remoteDataSource: RemoteDataSource
    private let _mapper: Transformer
    
    public init(
        game: GamesListDomainModel,
        remoteDataSource: RemoteDataSource,
        mapper: Transformer) {
        
        _game = game
        _remoteDataSource = remoteDataSource
        _mapper = mapper
    }
    
    public func execute(request: Any?) -> AnyPublisher<GameDetailDomainModel, Error> {
        return _remoteDataSource.execute(request: _game.idGame as? RemoteDataSource.Request)
              .map { _mapper.transformResponseToEntity(response: $0) }
              .map { _mapper.transformEntityToDomain(entity: $0) }
              .eraseToAnyPublisher()
    }
}
