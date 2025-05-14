//
//  SignedInView.swift
//  SignInPage
//
//  Created by EMILY on 13/05/2025.
//

import UIKit

// controller에서 button action을 수행하기 위한 custom delegate
protocol SignedInDelegate: AnyObject {
    func signOutButtonTapped()
    func deleteAccountButtonTapped()
}

// 로그인 성공 화면 view
class SignedInView: UIView {
    
    private weak var delegate: SignedInDelegate?
    
    // {닉네임} 님, 환영합니다.
    private let messageLabel: UILabel = {
        let label = UILabel()
        
        label.textColor = .label
        label.font = .boldSystemFont(ofSize: 27)
        
        return label
    }()
    
    // 로그아웃 버튼
    private lazy var signOutButton: CustomButton = .init(buttonSort: .signOut)
    
    // 회원탈퇴 버튼
    private lazy var deleteAccountButton: CustomButton = .init(buttonSort: .deleteAccount)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews([messageLabel, signOutButton, deleteAccountButton])
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupButtons(delegate: SignedInDelegate) {
        signOutButton.addTarget(self, action: #selector(signOutButtonTapped), for: .touchUpInside)
        deleteAccountButton.addTarget(self, action: #selector(deleteAccountButtonTapped), for: .touchUpInside)
        self.delegate = delegate
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

extension SignedInView {
    @objc private func signOutButtonTapped() {
        delegate?.signOutButtonTapped()
    }
    
    @objc private func deleteAccountButtonTapped() {
        delegate?.deleteAccountButtonTapped()
    }
}
