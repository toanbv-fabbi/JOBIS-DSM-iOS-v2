import UIKit
import Presentation
import Swinject
import RxFlow
import Core

public final class RecruitmentFilterFlow: Flow {
    public let container: Container
    private let rootViewController: RecruitmentFilterViewController
    public var root: Presentable {
        return rootViewController
    }

    public init(container: Container) {
        self.container = container
        self.rootViewController = container.resolve(RecruitmentFilterViewController.self)!
    }

    public func navigate(to step: Step) -> FlowContributors {
        guard let step = step as? RecruitmentFilterStep else { return .none }

        switch step {
        case .recruitmentFilterIsRequired:
            return navigateToRecruitmentFilter()

        case let .popToRecruitment(jobCode, techCode):
            return popToRecruitment(jobCode: jobCode ?? "", techCode: techCode ?? "")
        }
    }
}

private extension RecruitmentFilterFlow {
    func navigateToRecruitmentFilter() -> FlowContributors {
        return .one(flowContributor: .contribute(
            withNextPresentable: rootViewController,
            withNextStepper: rootViewController.viewModel
        ))
    }

    func popToRecruitment(jobCode: String, techCode: String) -> FlowContributors {

        let view = container.resolve(RecruitmentViewController.self)!

        print("view:", view)
        print("job, techCode:", jobCode, techCode)
        view.viewModel.jobCode = jobCode
        view.viewModel.techCode = techCode
        print("viewModel job, techCode:", view.viewModel.jobCode, view.viewModel.techCode)
        self.rootViewController.navigationController?.popViewController(animated: true)

        return .none
    }
}
