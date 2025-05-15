//
//  SignUpView.swift
//  SignInPage
//
//  Created by EMILY on 13/05/2025.
//

import UIKit

// controller에서 button action을 수행하기 위한 custom delegate
protocol SignUpDelegate: AnyObject {
    func signUpButtonTapped()
}

// 회원가입 화면 view
class SignUpView: UIView {
    
    private weak var delegate: SignUpDelegate?
    
    // 아이디(이메일) 입력 필드
    private let emailInputBox: InputBoxView = .init(inputSort: .email)
    
    // 비밀번호 입력 필드
    private let passwordInputBox: InputBoxView = .init(inputSort: .password)
    
    // 비밀번호 확인 입력 필드
    private let passwordConfirmationInputBox: InputBoxView = .init(inputSort: .passwordConfirmation)
    
    // 닉네임 입력 필드
    private let nicknameInputBox: InputBoxView = .init(inputSort: .nickname)
    
    // 회원가입 버튼
    private lazy var signUpButton: CustomButton = .init(buttonSort: .signUp)
    
    /* controller에서 텍스트필드 입력값에 접근하기 위한 프로퍼티 */
    
    // 이메일 : 공백을 제거한 뒤 반환
    var emailText: String {
        return emailInputBox.text.replacingOccurrences(of: " ", with: "")
    }
    
    // 비밀번호 & 비밀번호 확인 입력값은 공백 허용 : 공백을 제거하면 공백 위치가 달라도 일치 판정 되기 때문
    var passwordText: String {
        return passwordInputBox.text
    }
    
    var passwordConfirmationText: String {
        return passwordConfirmationInputBox.text
    }
    
    // 닉네임 : 공백을 제거한 뒤 반환
    var nicknameText: String {
        return nicknameInputBox.text.replacingOccurrences(of: " ", with: "")
    }
    
    /* controller에서 텍스트필드에 접근하기 위한 프로퍼티 */
    
    var emailTextField: UITextField {
        return emailInputBox.textField
    }
    
    var passwordTextField: UITextField {
        return passwordInputBox.textField
    }
    
    var passwordConfirmationTextField: UITextField {
        return passwordConfirmationInputBox.textField
    }
    
    var nicknameTextField: UITextField {
        return nicknameInputBox.textField
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews([
            emailInputBox,
            passwordInputBox,
            passwordConfirmationInputBox,
            nicknameInputBox,
            signUpButton
        ])
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupSignUpButton(delegate: SignUpDelegate) {
        // 회원가입 버튼 초기화 : 비활성 상태
        signUpButton.isEnabled = false
        signUpButton.backgroundColor = signUpButton.buttonSort.disabledBackgroundColor
        
        // button action을 위한 설정
        signUpButton.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
        self.delegate = delegate
    }
    
    func setupTextFieldDelegate(with delegate: UITextFieldDelegate) {
        emailInputBox.textField.delegate = delegate
        passwordInputBox.textField.delegate = delegate
        passwordConfirmationInputBox.textField.delegate = delegate
        nicknameInputBox.textField.delegate = delegate
    }
    
    // 각 텍스트필드 입력값이 변할 때마다 호출되어 회원가입 버튼 활성화 여부를 정한다
    func toggleButtonEnabled(to isEnabled: Bool) {
        signUpButton.isEnabled = isEnabled
        
        if isEnabled {
            signUpButton.backgroundColor = signUpButton.buttonSort.backgroundColor
        } else {
            signUpButton.backgroundColor = signUpButton.buttonSort.disabledBackgroundColor
        }
    }
    
    private func layout() {
        NSLayoutConstraint.activate([
            emailInputBox.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            emailInputBox.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            emailInputBox.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            passwordInputBox.leadingAnchor.constraint(equalTo: emailInputBox.leadingAnchor),
            passwordInputBox.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            passwordInputBox.topAnchor.constraint(equalTo: emailInputBox.bottomAnchor, constant: 16),
            
            passwordConfirmationInputBox.leadingAnchor.constraint(equalTo: emailInputBox.leadingAnchor),
            passwordConfirmationInputBox.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            passwordConfirmationInputBox.topAnchor.constraint(equalTo: passwordInputBox.bottomAnchor, constant: 8),
            
            nicknameInputBox.leadingAnchor.constraint(equalTo: emailInputBox.leadingAnchor),
            nicknameInputBox.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            nicknameInputBox.topAnchor.constraint(equalTo: passwordConfirmationInputBox.bottomAnchor, constant: 16),
            
            signUpButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            signUpButton.topAnchor.constraint(equalTo: nicknameInputBox.bottomAnchor, constant: 25)
        ])
    }
    
    @objc private func signUpButtonTapped() {
        delegate?.signUpButtonTapped()
    }
}
