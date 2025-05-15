//
//  SignInView.swift
//  SignInPage
//
//  Created by EMILY on 15/05/2025.
//

import UIKit

// controller에서 button action을 수행하기 위한 custom delegate
protocol SignInDelegate: AnyObject {
    func signUpButtonTapped()
    func signInButtonTapped()
}

// 로그인 화면 view
class SignInView: UIView {
    
    private weak var delegate: SignInDelegate?
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        
        label.text = "로그인"
        label.font = .boldSystemFont(ofSize: 30)
        label.textColor = .label
        
        return label
    }()
    
    private let emailInputBox: InputBoxView = .init(inputSort: .email)
    
    private let passwordInputBox: InputBoxView = .init(inputSort: .password)
    
    private lazy var saveInfoButton: UIButton = {
        let button = UIButton()
        
        button.configuration = .tinted()
        button.configuration?.baseBackgroundColor = .systemGray2
        button.configuration?.baseForegroundColor = .systemGray
        button.configuration?.title = "로그인 정보 저장"
        button.configuration?.image = UIImage(systemName: "circle")
        button.configuration?.imagePadding = 6
        
        return button
    }()
    
    private lazy var signUpButton: UIButton = {
        let button = UIButton()
        
        button.configuration = .tinted()
        button.configuration?.baseBackgroundColor = .systemCyan.withAlphaComponent(0.5)
        button.configuration?.baseForegroundColor = .systemCyan
        button.configuration?.title = "회원가입"
        
        return button
    }()
    
    private lazy var signInButton: CustomButton = .init(buttonSort: .signIn)
    
    /* controller에서 텍스트필드 입력값에 접근하기 위한 프로퍼티 */
    
    // 이메일 : 공백을 제거한 뒤 반환
    var emailText: String {
        return emailInputBox.text.replacingOccurrences(of: " ", with: "")
    }
    
    // 비밀번호 : 공백을 제거하지 않고 반환
    var passwordText: String {
        return passwordInputBox.text
    }
    
    /* 텍스트필드에 접근하기 위한 프로퍼티 */
    var emailTextField: UITextField {
        return emailInputBox.textField
    }
    
    var passwordTextField: UITextField {
        return passwordInputBox.textField
    }
    
    // 로그인 정보 저장 여부
    var saveLoginInfo: Bool {
        return saveInfoButton.isSelected
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews([
            titleLabel,
            emailInputBox,
            passwordInputBox,
            saveInfoButton,
            signUpButton,
            signInButton
        ])
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupTextFields(delegate: UITextFieldDelegate) {
        emailTextField.delegate = delegate
        passwordTextField.delegate = delegate
        passwordTextField.returnKeyType = .done
    }
    
    func setupSignInButton(delegate: SignInDelegate) {
        // 로그인 버튼 초기화 : 비활성 상태
        signInButton.isEnabled = false
        signInButton.backgroundColor = signInButton.buttonSort.disabledBackgroundColor
        
        // button action을 위한 설정
        saveInfoButton.addTarget(self, action: #selector(saveInfoButtonTapped), for: .touchUpInside)
        signUpButton.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
        signInButton.addTarget(self, action: #selector(signInButtonTapped), for: .touchUpInside)
        self.delegate = delegate
    }
    
    // 각 텍스트필드 입력값이 변할 때마다 호출되어 로그인 버튼 활성화 여부를 정한다
    func toggleSignInbuttonEnabled(to isEnabled: Bool) {
        signInButton.isEnabled = isEnabled
        
        if isEnabled {
            signInButton.backgroundColor = signInButton.buttonSort.backgroundColor
        } else {
            signInButton.backgroundColor = signInButton.buttonSort.disabledBackgroundColor
        }
    }
    
    private func layout() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            
            emailInputBox.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 40),
            emailInputBox.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            emailInputBox.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            passwordInputBox.topAnchor.constraint(equalTo: emailInputBox.bottomAnchor, constant: 10),
            passwordInputBox.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            passwordInputBox.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            saveInfoButton.topAnchor.constraint(equalTo: passwordInputBox.bottomAnchor, constant: 40),
            saveInfoButton.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            
            signUpButton.leadingAnchor.constraint(equalTo: saveInfoButton.trailingAnchor, constant: 10),
            signUpButton.centerYAnchor.constraint(equalTo: saveInfoButton.centerYAnchor),
            
            signInButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            signInButton.topAnchor.constraint(equalTo: saveInfoButton.bottomAnchor, constant: 30)
        ])
    }
    
    private func toggleSaveInfoButtonImage(with isSelected: Bool) {
        if isSelected {
            saveInfoButton.configuration?.baseBackgroundColor = .systemBlue.withAlphaComponent(0.5)
            saveInfoButton.configuration?.baseForegroundColor = .systemBlue
            saveInfoButton.configuration?.image = UIImage(systemName: "checkmark.circle")
        } else {
            saveInfoButton.configuration?.baseBackgroundColor = .systemGray2
            saveInfoButton.configuration?.baseForegroundColor = .systemGray
            saveInfoButton.configuration?.image = UIImage(systemName: "circle")
        }
    }
    
    @objc private func saveInfoButtonTapped() {
        saveInfoButton.isSelected.toggle()
        toggleSaveInfoButtonImage(with: saveInfoButton.isSelected)
    }
    
    @objc private func signUpButtonTapped() {
        delegate?.signUpButtonTapped()
    }
    
    @objc private func signInButtonTapped() {
        delegate?.signInButtonTapped()
    }
}
