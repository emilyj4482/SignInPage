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
        
        label.font = .boldSystemFont(ofSize: 27)
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews([messageLabel])
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout() {
        NSLayoutConstraint.activate([
            messageLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            messageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20)
        ])
    }
    
    func configureSubviews(with name: String) {
        messageLabel.text = "\(name)님, 환영합니다 🤗"
    }
}
