//
//  StartViewController.swift
//  SignInPage
//
//  Created by EMILY on 12/05/2025.
//

import UIKit

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
    func startButtonTapped() {
        var vc: UIViewController
        
        if let user = repository.fetchUser() {
            vc = SignedInViewController(repository: repository, user: user)
        } else {
            vc = SignUpViewController(repository: repository)
        }
        
        navigationController?.pushViewController(vc, animated: true)
    }
}
