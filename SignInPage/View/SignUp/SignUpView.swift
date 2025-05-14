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
    
    private let emailInputBox: InputBoxView = .init(inputSort: .email)
    
    private let passwordInputBox: InputBoxView = .init(inputSort: .password)
    
    private let passwordConfirmationInputBox: InputBoxView = .init(inputSort: .passwordConfirmation)
    
    private let nicknameInputBox: InputBoxView = .init(inputSort: .nickname)
    
    private lazy var signUpButton: CustomButton = .init(buttonSort: .signUp)
    
    var emailText: String {
        return emailInputBox.text
    }
    
    var passwordText: String {
        return passwordInputBox.text
    }
    
    var passwordConfirmationText: String {
        return passwordConfirmationInputBox.text
    }
    
    var nicknameText: String {
        return nicknameInputBox.text
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
        signUpButton.isEnabled = false
        signUpButton.backgroundColor = .systemGray4
        signUpButton.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
        self.delegate = delegate
    }
    
    func setupTextFieldDelegate(with delegate: UITextFieldDelegate) {
        emailInputBox.textField.delegate = delegate
        passwordInputBox.textField.delegate = delegate
        passwordConfirmationInputBox.textField.delegate = delegate
        nicknameInputBox.textField.delegate = delegate
    }
    
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
