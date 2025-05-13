//
//  SignedInView.swift
//  SignInPage
//
//  Created by EMILY on 13/05/2025.
//

import UIKit

class SignedInView: UIView {
    
    private let messageLabel: UILabel = {
        let label = UILabel()
        
        label.textColor = .label
        label.font = .boldSystemFont(ofSize: 27)
        
        return label
    }()
    
    private lazy var signOutButton: CustomButton = .init(buttonSort: .signOut)
    
    private lazy var deleteAccountButton: CustomButton = .init(buttonSort: .deleteAccount)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews([messageLabel, signOutButton, deleteAccountButton])
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout() {
        NSLayoutConstraint.activate([
            messageLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            messageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            
            signOutButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            signOutButton.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -50),
            
            deleteAccountButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            deleteAccountButton.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 50)
        ])
    }
    
    func configureSubviews(with name: String) {
        messageLabel.text = "\(name)님, 환영합니다 🤗"
    }
}

#Preview {
    SignedInViewController()
}
