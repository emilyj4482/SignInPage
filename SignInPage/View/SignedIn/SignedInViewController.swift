//
//  SignedInViewController.swift
//  SignInPage
//
//  Created by EMILY on 13/05/2025.
//

import UIKit

class SignedInViewController: UIViewController {
    
    let repository: UserRepository
    let user: UserEntity
    
    init(repository: UserRepository, user: UserEntity) {
        self.repository = repository
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let containerView: SignedInView = .init()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView(with: containerView)
        containerView.configureSubviews(with: user.nickname ?? "사용자")
        setupButtons()
    }
    
    private func setupButtons() {
        containerView.setupButtons(delegate: self)
    }
}

extension SignedInViewController: SignedInDelegate {
    func signOutButtonTapped() {
        print("[로그인 성공 화면] 로그아웃 button tapped")
        navigationController?.popViewController(animated: true)
    }
    
    func deleteAccountButtonTapped() {
        print("[로그인 성공 화면] 회원탈퇴 button tapped")
        repository.deleteUser(user.objectID)
        navigationController?.popViewController(animated: true)
    }
}
