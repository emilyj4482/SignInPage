//
//  SignUpView.swift
//  SignInPage
//
//  Created by EMILY on 13/05/2025.
//

import UIKit

protocol SignUpDelegate: AnyObject {
    func signUpButtonTapped()
}

class SignUpView: UIView {
    
    private weak var delegate: SignUpDelegate?
    
    private let messageLabel: UILabel = {
        let label = UILabel()
        
        label.text = "회원가입을 하면 이용이 가능해요."
        label.font = .preferredFont(forTextStyle: .title2)
        
        return label
    }()
    
    private let emailInputBox: InputBoxView = .init(inputSort: .email)
    
    private let passwordInputBox: InputBoxView = .init(inputSort: .password)
    
    private let passwordConfirmationInputBox: InputBoxView = .init(inputSort: .passwordConfirmation)
    
    private let nicknameInputBox: InputBoxView = .init(inputSort: .nickname)
    
    private lazy var signUpButton: CustomButton = .init(buttonSort: .signUp)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews([
            messageLabel,
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
        signUpButton.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
        self.delegate = delegate
    }
    
    private func layout() {
        NSLayoutConstraint.activate([
            messageLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            messageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            
            emailInputBox.leadingAnchor.constraint(equalTo: messageLabel.leadingAnchor),
            emailInputBox.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            emailInputBox.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 50),
            
            passwordInputBox.leadingAnchor.constraint(equalTo: messageLabel.leadingAnchor),
            passwordInputBox.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            passwordInputBox.topAnchor.constraint(equalTo: emailInputBox.bottomAnchor, constant: 16),
            
            passwordConfirmationInputBox.leadingAnchor.constraint(equalTo: messageLabel.leadingAnchor),
            passwordConfirmationInputBox.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            passwordConfirmationInputBox.topAnchor.constraint(equalTo: passwordInputBox.bottomAnchor, constant: 8),
            
            nicknameInputBox.leadingAnchor.constraint(equalTo: messageLabel.leadingAnchor),
            nicknameInputBox.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            nicknameInputBox.topAnchor.constraint(equalTo: passwordConfirmationInputBox.bottomAnchor, constant: 16),
            
            signUpButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            signUpButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20)
        ])
    }
    
    @objc private func signUpButtonTapped() {
        delegate?.signUpButtonTapped()
    }
}

#Preview {
    SignUpViewController()
}
