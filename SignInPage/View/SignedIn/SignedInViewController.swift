//
//  SignedInViewController.swift
//  SignInPage
//
//  Created by EMILY on 13/05/2025.
//

import UIKit

class SignedInViewController: UIViewController {
    
    private let containerView: SignedInView = .init()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView(with: containerView)
        containerView.configureSubviews(with: "에밀리")
        setupButtons()
    }
    
    private func setupButtons() {
        containerView.setupButtons(delegate: self)
    }
}

extension SignedInViewController: SignedInDelegate {
    func signOutButtonTapped() {
        print("sign out button tapped")
        navigationController?.popViewController(animated: true)
    }
    
    func deleteAccountButtonTapped() {
        print("delete account button tapped")
        navigationController?.popViewController(animated: true)
    }
}
