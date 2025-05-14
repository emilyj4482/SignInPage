//
//  SignInViewController.swift
//  SignInPage
//
//  Created by EMILY on 15/05/2025.
//

import UIKit

// 로그인 화면 controller
class SignInViewController: UIViewController {
    
    let repository: UserRepository
    
    init(repository: UserRepository) {
        self.repository = repository
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let containerView: SignInView = .init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView(with: containerView)
        setupContainerView()
        setupTapGesture()
    }
    
    private func setupContainerView() {
        containerView.setupTextFieldDelegate(with: self)
        containerView.setupSignInButton(delegate: self)
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

extension SignInViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard
            !containerView.emailText.isEmpty,
            !containerView.passwordText.isEmpty
        else {
            containerView.toggleSignInbuttonEnabled(to: false)
            return
        }
        
        containerView.toggleSignInbuttonEnabled(to: true)
    }
}

extension SignInViewController: SignInDelegate {
    // 회원가입 버튼 tap : 회원가입 화면으로 이동
    func signUpButtonTapped() {
        let vc = SignUpViewController(repository: repository)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    // 로그인 버튼 tap : 입력값 검사 결과에 따라 로그인 성공(화면으로 이동) 또는 실패(alert 호출) 동작 결정
    func signInButtonTapped() {
        let result = checkInputBoxs()
        
        switch result {
        case .success(let user):
            // 로그인 정보 저장 체크 여부에 따라 UserDefaults에 저장
            if containerView.saveLoginInfo {
                repository.saveLoginInfo(user.objectID.uriRepresentation().absoluteString)
            } else {
                repository.deleteLoginInfo()
            }
            // 로그인 성공 화면으로 이동
            let vc = SignedInViewController(repository: repository, user: user)
            navigationController?.pushViewController(vc, animated: true)
        default:
            showAlert(result)
        }
    }
    
    // 입력값 검사
    private func checkInputBoxs() -> SignInCase {
        guard let userFoundWithEmail = repository.searchUser(with: containerView.emailText) else {
            return .unregisteredEmail
        }
        
        guard userFoundWithEmail.password == containerView.passwordText else {
            return .incorrectPassword
        }
        
        return .success(userFoundWithEmail)
    }
    
    private func showAlert(_ result: SignInCase) {
        let alert = UIAlertController(title: "로그인 실패", message: result.alertMessage, preferredStyle: .alert)
        let okayAction = UIAlertAction(title: "확인", style: .default)
        alert.addAction(okayAction)
        present(alert, animated: true)
    }
}

enum SignInCase {
    case success(UserEntity)
    case unregisteredEmail
    case incorrectPassword
    
    var alertMessage: String {
        switch self {
        case .success:
            return "로그인 성공"
        case .unregisteredEmail:
            return "등록되지 않은 이메일입니다."
        case .incorrectPassword:
            return "비밀번호가 맞지 않습니다."
        }
    }
}
