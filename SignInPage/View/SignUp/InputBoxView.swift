//
//  InputBoxView.swift
//  SignInPage
//
//  Created by EMILY on 13/05/2025.
//

import UIKit

// 회원가입 화면에서 항목 이름 label + textfield 반복되는 영역 custom
class InputBoxView: UIStackView {
    
    // 입력 항목
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
    
    // 상위 객체에서 delegate 주입을 위해 textfield에 접근하기 위한 프로퍼티
    var textField: UITextField {
        return inputTextField
    }
    
    // textfield 입력값에서 공백을 제거한 값을 반환하여 접근하기 위한 프로퍼티
    var text: String {
        return inputTextField.text ?? ""
    }
    
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
    
    // 입력 항목 별로 view configuring
    private func configureSubviews() {
        inputTitleLabel.text = inputSort.inputTitle
        inputTextField.placeholder = inputSort.placeholder
        inputTextField.keyboardType = inputSort.keyboardType
        inputTextField.returnKeyType = inputSort.returnKeyType
        inputTextField.isSecureTextEntry = inputSort.isSecureTextEntry
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
    
    var isSecureTextEntry: Bool {
        switch self {
        case .password, .passwordConfirmation: return true
        default: return false
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
