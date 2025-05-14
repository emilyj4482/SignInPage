//
//  SignUpViewController.swift
//  SignInPage
//
//  Created by EMILY on 13/05/2025.
//

import UIKit

class SignUpViewController: UIViewController {
    
    private let containerView: SignUpView = .init()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView(with: containerView)
        setupNavigationTitle()
        setupTapGesture()
        setupdelegates()
    }
    
    private func setupNavigationTitle() {
        navigationItem.title = "회원가입"
    }
    
    private func setupTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(containerViewTapped))
        containerView.addGestureRecognizer(tapGesture)
    }
    
    private func setupdelegates() {
        containerView.setupTextFieldDelegate(with: self)
        containerView.setupSignUpButton(delegate: self)
    }
    
    @objc private func containerViewTapped() {
        containerView.endEditing(true)
    }
}

extension SignUpViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        let isEveryFieldFilled = checkEmptyFields()
        
        containerView.toggleButtonEnabled(to: isEveryFieldFilled)
    }
    
    private func checkEmptyFields() -> Bool {
        guard
            !containerView.emailText.isEmpty,
            !containerView.passwordText.isEmpty,
            !containerView.passwordConfirmationText.isEmpty,
            !containerView.nicknameText.isEmpty,
            containerView.passwordText == containerView.passwordConfirmationText
        else {
            return false
        }
        
        return true
    }
}

extension SignUpViewController: SignUpDelegate {
    func signUpButtonTapped() {
        let validationResult = checkInputBoxs()
        
        if validationResult == .valid {
            print(validationResult.message)
            // TODO: 회원정보 저장
            navigationController?.popViewController(animated: true)
        } else {
            print(validationResult.message)
        }
    }
    
    private func checkInputBoxs() -> ValidationCase {
        let emailTextArray = containerView.emailText.map({ $0 })
        
        guard
            let first = emailTextArray.first,
            let last = emailTextArray.last,
            first.isLowercase &&
            last.isLowercase &&
            emailTextArray.filter({ $0 == "@" }).count == 1 &&
            emailTextArray.filter({ $0 == "." }).count == 1 &&
            emailTextArray.filter({ $0 != "@" && $0 != "." && !$0.isLowercase && !$0.isNumber}).count == 0
        else {
            return .invalidEmail
        }
        
        guard
            let endIndex = emailTextArray.map({ String($0) }).firstIndex(of: "@"),
            (emailTextArray[emailTextArray.startIndex...endIndex].count >= 6 &&
             emailTextArray[emailTextArray.startIndex...endIndex].count <= 20)
        else {
            return .invalidEmail
        }
        
        guard containerView.passwordText.count >= 8 else {
            return .passwordTooShort
        }
        
        guard containerView.nicknameText.count >= 2 && containerView.nicknameText.count <= 8 else {
            return .invalidNickname
        }
        
        return .valid
    }
}
