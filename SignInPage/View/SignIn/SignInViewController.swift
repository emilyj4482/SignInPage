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
    // MARK: 로그인 버튼 tap 시
    func signInButtonTapped() {
        print("로그인 버튼 tap")
    }
}
