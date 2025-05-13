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
        setupNavigationTitle()
        setupTapGesture()
        setupSignUpButton()
    }
    
    private func setupNavigationTitle() {
        navigationItem.title = "회원가입"
    }
    
    private func setupTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(containerViewTapped))
        containerView.addGestureRecognizer(tapGesture)
    }
    
    private func setupSignUpButton() {
        containerView.setupSignUpButton(delegate: self)
    }
    
    @objc private func containerViewTapped() {
        containerView.endEditing(true)
    }
}

extension SignUpViewController: SignUpDelegate {
    func signUpButtonTapped() {
        print("sign up button tapped")
        navigationController?.popViewController(animated: true)
    }
}
