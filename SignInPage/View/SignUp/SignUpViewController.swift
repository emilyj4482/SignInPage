//
//  SignUpViewController.swift
//  SignInPage
//
//  Created by EMILY on 13/05/2025.
//

import UIKit

class SignUpViewController: UIViewController {
    
    private let containerView: SignUpView = .init()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView(with: containerView)
        setupSignUpButton()
    }
    
    private func setupSignUpButton() {
        containerView.setupSignUpButton(delegate: self)
    }
}

extension SignUpViewController: SignUpDelegate {
    func signUpButtonTapped() {
        print("sign up button tapped")
        navigationController?.popViewController(animated: true)
    }
}
