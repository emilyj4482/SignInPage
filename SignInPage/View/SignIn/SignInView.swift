//
//  SignInView.swift
//  SignInPage
//
//  Created by EMILY on 15/05/2025.
//

import UIKit

// controller에서 button action을 수행하기 위한 custom delegate
protocol SignInDelegate: AnyObject {
    // func saveInfoButtonTapped()
    func signInButtonTapped()
}

// 로그인 화면 view
class SignInView: UIView {
    
    private weak var delegate: SignInDelegate?
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        
        label.text = "로그인"
        label.font = .boldSystemFont(ofSize: 30)
        label.textColor = .label
        
        return label
    }()
    
    private let emailInputBox: InputBoxView = .init(inputSort: .email)
    
    private let passwordInputBox: InputBoxView = .init(inputSort: .password)
    
    private let saveInfoButton: UIButton = {
        let button = UIButton()
        
        button.configuration = .tinted()
        button.configuration?.baseBackgroundColor = .systemGray2
        button.configuration?.baseForegroundColor = .systemGray
        button.configuration?.title = "로그인 정보 저장"
        button.configuration?.image = UIImage(systemName: "circle")
        button.configuration?.imagePadding = 6
        
        return button
    }()
    
    private lazy var signInButton: CustomButton = .init(buttonSort: .signIn)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews([
            titleLabel,
            emailInputBox,
            passwordInputBox,
            saveInfoButton,
            signInButton
        ])
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupSignInButton(delegate: SignInDelegate) {
        saveInfoButton.addTarget(self, action: #selector(saveInfoButtonTapped), for: .touchUpInside)
        signInButton.addTarget(self, action: #selector(signInButtonTapped), for: .touchUpInside)
        self.delegate = delegate
    }
    
    private func layout() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            
            emailInputBox.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 40),
            emailInputBox.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            emailInputBox.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            passwordInputBox.topAnchor.constraint(equalTo: emailInputBox.bottomAnchor, constant: 10),
            passwordInputBox.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            passwordInputBox.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            saveInfoButton.topAnchor.constraint(equalTo: passwordInputBox.bottomAnchor, constant: 40),
            saveInfoButton.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            
            signInButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            signInButton.topAnchor.constraint(equalTo: saveInfoButton.bottomAnchor, constant: 20)
        ])
    }
    
    private func toggleSaveInfoButtonImage(with isSelected: Bool) {
        if isSelected {
            saveInfoButton.configuration?.baseBackgroundColor = .systemBlue.withAlphaComponent(0.5)
            saveInfoButton.configuration?.baseForegroundColor = .systemBlue
            saveInfoButton.configuration?.image = UIImage(systemName: "checkmark.circle")
        } else {
            saveInfoButton.configuration?.baseBackgroundColor = .systemGray2
            saveInfoButton.configuration?.baseForegroundColor = .systemGray
            saveInfoButton.configuration?.image = UIImage(systemName: "circle")
        }
    }
    
    @objc private func saveInfoButtonTapped() {
        saveInfoButton.isSelected.toggle()
        toggleSaveInfoButtonImage(with: saveInfoButton.isSelected)
    }
    
    @objc private func signInButtonTapped() {
        delegate?.signInButtonTapped()
    }
}

#Preview {
    SignInViewController(repository: UserRepository.init())
}
