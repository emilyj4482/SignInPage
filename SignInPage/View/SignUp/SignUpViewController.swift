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

enum ValidationCase {
    case valid
    case invalidEmail   // 1. 영문 소문자로만 시작하고 2. 영문 소문자와 숫자로만 이루어져있고 3. @와 .를 모두 포함한 이메일 형식 4. @ 앞부분이 6자 이상 20자 이하 >> 가 아닌 경우
    case emailAlreadyExists
    case passwordTooShort
    case invalidNickname    // 닉네임이 2자 이상 8자 이하가 아닌 경우
    
    var message: String {
        switch self {
        case .valid:
            return "회원가입이 완료되었습니다."
        case .invalidEmail:
            return "이메일 주소를 형식에 맞게 입력해주세요."
        case .emailAlreadyExists:
            return "이미 가입한 이메일입니다."
        case .passwordTooShort:
            return "비밀번호는 최소 8자 이상이어야 합니다."
        case .invalidNickname:
            return "닉네임은 2 ~ 8자로 입력해주세요."
        }
    }
}
