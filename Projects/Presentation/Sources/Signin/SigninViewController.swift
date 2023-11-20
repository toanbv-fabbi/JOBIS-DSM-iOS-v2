import UIKit
import RxSwift
import RxCocoa
import SnapKit
import Then
import Core
import DesignSystem

public class SigninViewController: BaseViewController<SigninViewModel> {
    private let titleLabel = UILabel().then {
        $0.setJobisText("JOBIS에 로그인하기", font: .pageTitle, color: .GrayScale.gray90)
        $0.setColorRange(color: .Main.blue1, range: "JOBIS")
    }
    private let titleLineView = UIView().then {
        $0.backgroundColor = .GrayScale.gray90
    }
    private let titleImageView = UIImageView().then {
        $0.image = .jobisIcon(.door)
    }
    public let emailTextField = JobisTextField().then {
        $0.setTextField(
            title: "이메일",
            placeholder: "example",
            textFieldType: .email
        )
    }
    public let passwordTextField = JobisTextField().then {
        $0.setTextField(
            title: "비밀번호",
            placeholder: "비밀번호를 입력해주세요",
            textFieldType: .secure
        )
    }
    public let signinButton = JobisButton(style: .main).then {
        $0.setText("로그인")
    }
    public override func addView() {
        [
            titleLabel,
            titleLineView,
            titleImageView,
            emailTextField,
            passwordTextField,
            signinButton
        ].forEach { self.view.addSubview($0) }
    }
    public override func layout() {
        titleLabel.snp.makeConstraints {
            $0.topMargin.equalToSuperview().inset(20)
            $0.leading.equalToSuperview().inset(24)
        }
        titleLineView.snp.makeConstraints {
            $0.centerY.equalTo(titleLabel.snp.centerY)
            $0.leading.equalTo(titleLabel.snp.trailing).offset(12)
            $0.trailing.equalTo(titleImageView.snp.leading).offset(-12)
            $0.height.equalTo(1)
        }
        titleImageView.snp.makeConstraints {
            $0.centerY.equalTo(titleLabel.snp.centerY)
            $0.width.height.equalTo(32)
            $0.trailing.equalToSuperview().inset(24)
        }
        emailTextField.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview()
        }
        passwordTextField.snp.makeConstraints {
            $0.top.equalTo(emailTextField.snp.bottom)
            $0.leading.trailing.equalToSuperview()
        }
        signinButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(46)
            $0.leading.trailing.equalToSuperview().inset(24)
        }
    }
    public override func bind() {
        let input = SigninViewModel.Input(
            email: emailTextField.textField.rx.text.orEmpty.asDriver(),
            password: passwordTextField.textField.rx.text.orEmpty.asDriver(),
            signinButtonDidTap: signinButton.rx.tap.asSignal()
        )
        let output = viewModel.transform(input)
        output.emailErrorDescription
            .bind { [self] description in
                print("email \(description)")
                emailTextField.setDescription(.error(description: description))
            }
            .disposed(by: disposeBag)
        output.passwordErrorDescription
            .bind { [self] description in
                print("password \(description)")
                passwordTextField.setDescription(.error(description: description))
            }
            .disposed(by: disposeBag)
    }
    public override func attribute() {
    }
}