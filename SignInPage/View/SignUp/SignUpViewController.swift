//
//  SignUpViewController.swift
//  SignInPage
//
//  Created by EMILY on 13/05/2025.
//

import UIKit

// 회원가입 화면 controller
class SignUpViewController: UIViewController {
    
    let repository: UserRepository
    
    init(repository: UserRepository) {
        self.repository = repository
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let containerView: SignUpView = .init()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView(with: containerView)
        setupNavigationTitle()
        setupContainerView()
        setupTapGesture()
    }
    
    private func setupNavigationTitle() {
        navigationItem.title = "회원가입"
    }
    
    private func setupContainerView() {
        containerView.setupTextFieldDelegate(with: self)
        containerView.setupSignUpButton(delegate: self)
    }
    
    // 화면을 탭하면 키보드가 내려가도록 하기 위한 tap gesture recognizer 설정
    private func setupTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(containerViewTapped))
        containerView.addGestureRecognizer(tapGesture)
    }
    
    // 텍스트필드 외 view tap 시 키보드 dismiss
    @objc private func containerViewTapped() {
        containerView.endEditing(true)
    }
}

extension SignUpViewController: UITextFieldDelegate {
    // textfield 입력값이 변할 때마다 호출 : 1. 모든 필드에 입력값이 있고, 2. 비밀번호 입력창과 확인창 값이 일치하면 >> 회원가입 버튼 enabled에 true, 아니면 false 할당
    func textFieldDidChangeSelection(_ textField: UITextField) {
        let isEveryFieldFilled = checkEmptyFields()
        
        containerView.toggleButtonEnabled(to: isEveryFieldFilled)
    }
    
    // textfield 검사 함수 : 입력 여부, 비밀번호 일치 여부
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
    // 회원가입 button tap 시 호출 : 모든 입력값 검사 통과 시 회원가입 성공, 아닐 시 실패 alert 호출 (성공 alert 확인 시 로그인 성공 화면으로 이동)
    func signUpButtonTapped() {
        let validationResult = checkInputBoxs()
        
        let alert = UIAlertController(title: validationResult.alertTitle, message: validationResult.alertMessage, preferredStyle: .alert)
        
        let success = UIAlertAction(title: "확인", style: .default) { [weak self] _ in
            self?.pushToSignedInViewController()
        }
        
        let fail = UIAlertAction(title: "확인", style: .default)
        
        if validationResult == .valid {
            createUser()
            alert.addAction(success)
        } else {
            alert.addAction(fail)
        }
        
        present(alert, animated: true)
    }
    
    // (회원가입 완료 후) 로그인 성공 화면으로 이동
    private func pushToSignedInViewController() {
        guard let user = repository.fetchUser() else { return }
        let vc = SignedInViewController(repository: repository, user: user)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    // textfield 검사 함수 : 입력값 유효 여부
    private func checkInputBoxs() -> ValidationCase {
        let emailTextArray = containerView.emailText.map({ $0 })
        
        // 이메일 검사 1 : 아이디는 이메일 주소여야 합니다. >> 영문 소문자와 숫자 조합만 허용, 입력값의 처음과 끝이 알파벳 소문자, @와 .가 한개씩만 존재
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
        
        // 이메일 검사 2 : 이메일 영역(@ 이후)을 제외하고 6자 이상 20자 이하
        guard
            let endIndex = emailTextArray.map({ String($0) }).firstIndex(of: "@"),
            (emailTextArray[emailTextArray.startIndex...endIndex].count >= 6 &&
             emailTextArray[emailTextArray.startIndex...endIndex].count <= 20)
        else {
            return .invalidEmail
        }
        
        // TODO: 이메일 중복 검사
        
        // 비밀번호 검사 : 최소 8자 이상
        guard containerView.passwordText.count >= 8 else {
            return .passwordTooShort
        }
        
        // 닉네임 검사 : 2자 이상 8자 이하
        guard containerView.nicknameText.count >= 2 && containerView.nicknameText.count <= 8 else {
            return .invalidNickname
        }
        
        return .valid
    }
    
    // 회원가입 : 유효한 회원 정보를 core data에 저장
    private func createUser() {
        let user = User(email: containerView.emailText, password: containerView.passwordText, nickname: containerView.nicknameText)
        
        repository.addUser(user)
    }
}

enum ValidationCase {
    case valid
    case invalidEmail   // 1. 영문 소문자로만 시작하고 2. 영문 소문자와 숫자로만 이루어져있고 3. @와 .를 모두 포함한 이메일 형식 4. @ 앞부분이 6자 이상 20자 이하 >> 가 아닌 경우
    case emailAlreadyExists // 이메일이 중복인 경우
    case passwordTooShort   // 비밀번호가 8자 미만인 경우
    case invalidNickname    // 닉네임이 2자 이상 8자 이하가 아닌 경우
    
    var alertTitle: String {
        switch self {
        case .valid: return "회원가입 성공"
        default: return "회원가입 실패"
        }
    }
    
    var alertMessage: String {
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
