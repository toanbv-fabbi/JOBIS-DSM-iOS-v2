import UIKit
import Presentation
import Swinject
import RxFlow
import Core

public final class NoticeFlow: Flow {
    public let container: Container
    private let rootViewController: NoticeViewController
    public var root: Presentable {
        return rootViewController
    }

    public init(container: Container) {
        self.container = container
        self.rootViewController = container.resolve(NoticeViewController.self)!
    }

    public func navigate(to step: Step) -> FlowContributors {
        guard let step = step as? NoticeStep else { return .none }

        switch step {
        case .noticeIsRequired:
            return navigateToNotice()

        case .noticeDetailIsRequired:
            return navigateToNoticeDetail()
        }
    }
}

private extension NoticeFlow {
    func navigateToNotice() -> FlowContributors {
        return .one(flowContributor: .contribute(
            withNextPresentable: rootViewController,
            withNextStepper: rootViewController.viewModel
        ))
    }

    func navigateToNoticeDetail() -> FlowContributors {
        let noticeDetailViewController = self.container.resolve(NoticeDetailViewController.self)!

        self.rootViewController.navigationController?.pushViewController(
            noticeDetailViewController,
            animated: true
        )

        return .one(flowContributor: .contribute(
            withNextPresentable: noticeDetailViewController,
            withNextStepper: noticeDetailViewController.viewModel
        ))
    }
}
