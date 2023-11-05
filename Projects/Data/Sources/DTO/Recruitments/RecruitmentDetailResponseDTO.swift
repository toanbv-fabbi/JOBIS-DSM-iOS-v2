import Foundation
import Domain

public struct RecruitmentDetailResponseDTO: Decodable {
    public let companyID: Int
    public let companyProfileUrl: String
    public let companyName: String
    public let areas: [AreaResponseDTO]
    public let requiredGrade: Int?
    public let startTime, endTime: String
    public let requiredLicenses: [String]?
    public let hiringProgress: [InterviewType]
    public let trainPay: Int
    public let pay: String?
    public let benefits: String?
    public let military: Bool
    public let submitDocument: String
    public let startDate, endDate: String
    public let etc: String?

    public init(
        companyID: Int,
        companyProfileUrl: String,
        companyName: String,
        areas: [AreaResponseDTO],
        requiredGrade: Int?,
        startTime: String,
        endTime: String,
        requiredLicenses: [String]?,
        hiringProgress: [InterviewType],
        trainPay: Int,
        pay: String?,
        benefits: String?,
        military: Bool,
        submitDocument: String,
        startDate: String,
        endDate: String,
        etc: String?
    ) {
        self.companyID = companyID
        self.companyProfileUrl = companyProfileUrl
        self.companyName = companyName
        self.areas = areas
        self.requiredGrade = requiredGrade
        self.startTime = startTime
        self.endTime = endTime
        self.requiredLicenses = requiredLicenses
        self.hiringProgress = hiringProgress
        self.trainPay = trainPay
        self.pay = pay
        self.benefits = benefits
        self.military = military
        self.submitDocument = submitDocument
        self.startDate = startDate
        self.endDate = endDate
        self.etc = etc
    }

    enum CodingKeys: String, CodingKey {
        case companyID = "company_id"
        case companyProfileUrl = "company_profile_url"
        case companyName = "company_name"
        case areas
        case requiredGrade = "required_grade"
        case startTime = "start_time"
        case endTime = "end_time"
        case requiredLicenses = "required_licenses"
        case hiringProgress = "hiring_progress"
        case trainPay = "train_pay"
        case pay, benefits, military
        case submitDocument = "submit_document"
        case startDate = "start_date"
        case endDate = "end_date"
        case etc
    }
}

public extension RecruitmentDetailResponseDTO {
    func toDomain() -> RecruitmentDetailEntity {
        var unwrappedRequiredGrade: String? {
            guard let requiredGrade else { return nil }
            return String(requiredGrade) + "% 이내"
        }
        var workTime: String {
            [startTime, endTime].map {
                $0.components(separatedBy: ":")[0...1].joined(separator: ":")
            }.joined(separator: " ~ ")
        }
        return RecruitmentDetailEntity(
            companyID: companyID,
            companyProfileUrl: companyProfileUrl,
            companyName: companyName,
            areas: areas.map { $0.toDomain() },
            requiredGrade: unwrappedRequiredGrade,
            workTime: workTime,
            requiredLicenses: requiredLicenses?.joined(separator: ", "),
            hiringProgress: hiringProgress.enumerated().map { (index, value) in
                "\(index + 1). \(value.localizedString())"
            }.joined(separator: "\n"),
            trainPay: String(trainPay),
            pay: pay,
            benefits: benefits,
            military: military,
            submitDocument: submitDocument,
            startDate: startDate,
            endDate: endDate,
            etc: etc ?? "없음"
        )
    }
}
