//
//  CustomButton.swift
//  SignInPage
//
//  Created by EMILY on 13/05/2025.
//

import UIKit

// 앱의 모든 버튼을 공통으로 custom
class CustomButton: UIButton {
    
    // 버튼 종류
    let buttonSort: ButtonSort
    
    init(buttonSort: ButtonSort) {
        self.buttonSort = buttonSort
        super.init(frame: .zero)
        setupUI()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // 버튼 종류에 따라 view configuring
    private func setupUI() {
        backgroundColor = buttonSort.backgroundColor
        setTitle(buttonSort.buttonTitle, for: .normal)
        setTitleColor(.systemBackground, for: .normal)
    }
    
    private func layout() {
        layer.cornerRadius = 30
        
        NSLayoutConstraint.activate([
            widthAnchor.constraint(equalToConstant: 200),
            heightAnchor.constraint(equalToConstant: 60)
        ])
    }
}

enum ButtonSort {
    case start
    case signUp
    case signIn
    case signOut
    case deleteAccount
    
    var buttonTitle: String {
        switch self {
        case .start: return "시작하기"
        case .signUp: return "회원가입"
        case .signIn: return "로그인"
        case .signOut: return "로그아웃"
        case .deleteAccount:  return "회원탈퇴"
        }
    }
    
    var backgroundColor: UIColor {
        switch self {
        case .start, .signUp, .signIn: return .systemTeal
        case .signOut: return .systemRed
        case .deleteAccount:  return .systemGray4
        }
    }
    
    var disabledBackgroundColor: UIColor {
        return .systemGray5
    }
}
