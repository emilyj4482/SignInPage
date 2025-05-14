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
        setupSignInButton()
    }
    
    private func setupSignInButton() {
        containerView.setupSignInButton(delegate: self)
    }
}

extension SignInViewController: SignInDelegate {
    // MARK: 로그인 버튼 tap 시
    func signInButtonTapped() {
        print("로그인 버튼 tap")
    }
}
