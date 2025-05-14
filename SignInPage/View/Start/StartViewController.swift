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
    // 시작하기 버튼 tap 시 로그인 정보 저장 여부 & 회원 존재 유무 검사하여 각 화면으로 이동
    func startButtonTapped() {
        var vc: UIViewController
        
        if repository.isLoginSaved {
            // 로그인 정보 저장 O : 저장된 사용자 id 확인하여 로그인 성공 화면으로 이동
            guard
                let idFromUserDefaults = repository.savedUserID,
                let url = URL(string: idFromUserDefaults),
                let convertedID = repository.context.persistentStoreCoordinator?.managedObjectID(forURIRepresentation: url),
                let user = repository.fetchUser(with: convertedID)
            else { return }
            
            vc = SignedInViewController(repository: repository, user: user)
        } else {
            // 로그인 정보 저장 X : 가입한 회원 정보 있을 시 로그인 화면, 없을 시 회원가입 화면으로 이동
            if repository.hasUsers {
                vc = SignUpViewController(repository: repository)
            } else {
                vc = SignInViewController(repository: repository)
            }
        }
        
        navigationController?.pushViewController(vc, animated: true)
    }
}
