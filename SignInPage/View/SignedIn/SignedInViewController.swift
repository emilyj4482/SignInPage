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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        resetNavigationStack()
    }
    
    private func setupButtons() {
        containerView.setupButtons(delegate: self)
    }
    
    // 회원가입 or 로그인 화면을 navigation stack에서 제거 (Back 버튼 눌렀을 때 시작화면으로 바로 돌아가기 위함)
    private func resetNavigationStack() {
        guard
            var viewControllers = navigationController?.viewControllers,
            viewControllers.count > 2
        else {
            return
        }
        
        viewControllers.remove(at: 1)
        navigationController?.setViewControllers(viewControllers, animated: false)
    }
}

extension SignedInViewController: SignedInDelegate {
    // 로그아웃 버튼 tap : 로그인 정보 삭제한 뒤 시작 화면으로 이동
    func signOutButtonTapped() {
        print("[로그인 성공 화면] 로그아웃 button tapped")
        repository.deleteLoginInfo()
        navigationController?.popViewController(animated: true)
    }
    
    // 회원탈퇴 버튼 tap : 로그인 정보 삭제 및 사용자 데이터를 core data에서 삭제 후 시작 화면으로 이동
    func deleteAccountButtonTapped() {
        print("[로그인 성공 화면] 회원탈퇴 button tapped")
        repository.deleteLoginInfo()
        repository.deleteUser(user.objectID)
        navigationController?.popViewController(animated: true)
    }
}
