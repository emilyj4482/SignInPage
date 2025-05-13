//
//  InputBoxView.swift
//  SignInPage
//
//  Created by EMILY on 13/05/2025.
//

import UIKit

class InputBoxView: UIStackView {
    
    let inputSort: InputSort
    
    private let inputTitleLabel: UILabel = {
        let label = UILabel()
        
        label.textColor = .label
        label.font = .preferredFont(forTextStyle: .subheadline)
        
        return label
    }()
    
    private let inputTextField: UITextField = {
        let textField = UITextField()
        
        textField.textColor = .label
        textField.font = .preferredFont(forTextStyle: .body)
        textField.backgroundColor = .systemGray6
        textField.layer.cornerRadius = 4
        
        return textField
    }()
    
    init(inputSort: InputSort) {
        self.inputSort = inputSort
        super.init(frame: .zero)
        setupArrangedSubviews([inputTitleLabel, inputTextField])
        layout()
        configureSubviews()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout() {
        axis = .vertical
        alignment = .leading
        spacing = 6
        
        NSLayoutConstraint.activate([
            inputTextField.trailingAnchor.constraint(equalTo: trailingAnchor),
            inputTextField.heightAnchor.constraint(equalToConstant: 35),
            
            heightAnchor.constraint(equalToConstant: 70)
        ])
    }
    
    private func configureSubviews() {
        inputTitleLabel.text = inputSort.inputTitle
        inputTextField.placeholder = inputSort.placeholder
        inputTextField.keyboardType = inputSort.keyboardType
        inputTextField.returnKeyType = inputSort.returnKeyType
    }
}

enum InputSort {
    case email
    case password
    case passwordConfirmation
    case nickname
    
    var inputTitle: String {
        switch self {
        case .email: return "아이디"
        case .password: return "비밀번호"
        case .passwordConfirmation: return "비밀번호 확인"
        case .nickname: return "닉네임"
        }
    }
    
    var placeholder: String {
        switch self {
        case .email: return "이메일 형태로 입력해주세요."
        case .password: return "최소 8자 이상으로 입력해주세요."
        case .passwordConfirmation: return "비밀번호를 한번 더 입력해주세요."
        case .nickname: return "닉네임을 입력해주세요."
        }
    }
    
    var keyboardType: UIKeyboardType {
        switch self {
        case .email: return .emailAddress
        default: return .default
        }
    }
    
    var returnKeyType: UIReturnKeyType {
        switch self {
        case .nickname: return .done
        default: return .next
        }
    }
}
