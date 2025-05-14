//
//  SignedInViewController.swift
//  SignInPage
//
//  Created by EMILY on 13/05/2025.
//

import UIKit

// 로그인 성공 화면 controller
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
        // 전달 받은 사용자의 닉네임을 label에 표시
        containerView.configureSubviews(with: user.nickname ?? "사용자")
        setupButtons()
    }
    
    private func setupButtons() {
        containerView.setupButtons(delegate: self)
    }
}

extension SignedInViewController: SignedInDelegate {
    // 로그아웃 버튼 tap : 다른 동작 없이 시작 화면으로 이동
    func signOutButtonTapped() {
        print("[로그인 성공 화면] 로그아웃 button tapped")
        navigationController?.popViewController(animated: true)
    }
    
    // 회원탈퇴 버튼 tap : 사용자 데이터를 core data에서 삭제 후 시작 화면으로 이동
    func deleteAccountButtonTapped() {
        print("[로그인 성공 화면] 회원탈퇴 button tapped")
        repository.deleteUser(user.objectID)
        navigationController?.popViewController(animated: true)
    }
}
