//
//  SignUpView.swift
//  SignInPage
//
//  Created by EMILY on 13/05/2025.
//

import UIKit

protocol SignUpDelegate: AnyObject {
    func signUpButtonTapped()
}

class SignUpView: UIView {
    
    private weak var delegate: SignUpDelegate?
    
    private lazy var signUpButton: CustomButton = .init(buttonSort: .signUp)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews([signUpButton])
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupSignUpButton(delegate: SignUpDelegate) {
        signUpButton.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
        self.delegate = delegate
    }
    
    private func layout() {
        NSLayoutConstraint.activate([
            signUpButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            signUpButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20)
        ])
    }
    
    @objc private func signUpButtonTapped() {
        delegate?.signUpButtonTapped()
    }
}

#Preview {
    SignUpViewController()
}
