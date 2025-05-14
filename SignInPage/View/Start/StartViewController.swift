//
//  StartViewController.swift
//  SignInPage
//
//  Created by EMILY on 12/05/2025.
//

import UIKit

// 시작하기 화면 controller
class StartViewController: UIViewController {
    
    let repository: UserRepository
    
    init(repository: UserRepository) {
        self.repository = repository
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let containerView: StartView = .init()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView(with: containerView)
        setupStartButton()
    }
    
    private func setupStartButton() {
        containerView.setupStartButton(delegate: self)
    }
}

extension StartViewController: StartDelegate {
    // MARK: 시작하기 버튼 tap 시 회원 여부 검사하여 회원가입 또는 로그인 성공 화면으로 이동
    func startButtonTapped() {
        var vc: UIViewController
        
        if let user = repository.fetchUser() {
            // vc = SignedInViewController(repository: repository, user: user)
            vc = SignInViewController(repository: repository)
        } else {
            vc = SignUpViewController(repository: repository)
        }
        
        navigationController?.pushViewController(vc, animated: true)
    }
}
