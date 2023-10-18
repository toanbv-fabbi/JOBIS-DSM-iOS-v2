import RxSwift
import Domain

protocol CompaniesRemote {
    func fetchCompanyList(page: Int, name: String?) -> Single<[CompanyEntity]>
    func fetchCompanyInfoDetail(id: String) -> Single<CompanyInfoDetailEntity>
    func fetchWritableReviewList() -> Single<[WritableReviewCompanyEntity]>
}

final class CompaniesRemoteImpl: BaseRemote<CompaniesAPI>, CompaniesRemote {
    func fetchCompanyList(page: Int, name: String?) -> Single<[CompanyEntity]> {
        request(.fetchCompanyList(page: page, name: name))
            .map(CompanyListResponseDTO.self)
            .map { $0.toDomain() }
    }

    func fetchCompanyInfoDetail(id: String) -> Single<CompanyInfoDetailEntity> {
        request(.fetchCompanyInfoDetail(id: id))
            .map(CompanyInfoDetailResponseDTO.self)
            .map { $0.toDomain() }
    }

    func fetchWritableReviewList() -> Single<[WritableReviewCompanyEntity]> {
        request(.fetchWritableReviewList)
            .map(WritableReviewListResponseDTO.self)
            .map { $0.toDomain() }
    }
}