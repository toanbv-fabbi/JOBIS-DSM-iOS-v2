import Foundation
import Swinject
import Core
import Domain

public final class DataSourceAssembly: Assembly {
    public init() {}

    private let keychain = { (resolver: Resolver) in
        resolver.resolve(Keychain.self)!
    }

    public func assemble(container: Container) {
        container.register(AuthRemote.self) { resolver in
            AuthRemoteImpl(keychainLocal: self.keychain(resolver))
        }

        container.register(UsersRemote.self) { resolver in
            UsersRemoteImpl(keychainLocal: self.keychain(resolver))
        }

        container.register(CompaniesRemote.self) { resolver in
            CompaniesRemoteImpl(keychainLocal: self.keychain(resolver))
        }

        container.register(ReviewsRemote.self) { resolver in
            ReviewsRemoteImpl(keychainLocal: self.keychain(resolver))
        }

        container.register(ApplicationsRemote.self) { reslover in
            ApplicationsRemoteImpl(keychainLocal: self.keychain(reslover))
        }
      
        container.register(BugsRemote.self) { resolver in
            BugsRemoteImpl(keychainLocal: self.keychain(resolver))
        }

        container.register(BookmarksRemote.self) { resolver in
            BookmarksRemoteImpl(keychainLocal: self.keychain(resolver))
        }

        container.register(RecruitmentsRemote.self) { resolver in
            RecruitmentsRemoteImpl(keychainLocal: self.keychain(resolver))
        }

        container.register(CodesRemote.self) { resolver in
            CodesRemoteImpl(keychainLocal: self.keychain(resolver))
        }

        container.register(FilesRemote.self) { resolver in
            FilesRemoteImpl(keychainLocal: self.keychain(resolver))
        }
    }
}