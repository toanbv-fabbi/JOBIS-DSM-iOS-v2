import Foundation
import Swinject
import Core
import Domain

public final class PresentationAssembly: Assembly {
    public init() {}

    public func assemble(container: Container) {
        container.register(MainViewModel.self) { resolver in
            MainViewModel(
                signinUseCase: resolver.resolve(SigninUseCase.self)!,
                reissueTokenUseCase: resolver.resolve(ReissueTokenUaseCase.self)!
            )
        }
        container.register(MainViewController.self) { resolver in
            MainViewController(resolver.resolve(MainViewModel.self)!)
        }
    }
}