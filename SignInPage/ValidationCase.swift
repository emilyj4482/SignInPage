//
//  ValidationCase.swift
//  SignInPage
//
//  Created by EMILY on 14/05/2025.
//

import Foundation

enum ValidationCase {
    case valid
    case invalidEmail   // 1. 영문 소문자로만 시작하고 2. 영문 소문자와 숫자로만 이루어져있고 3. @와 .를 모두 포함한 이메일 형식 4. @ 앞부분이 6자 이상 20자 이하 >> 가 아닌 경우
    case emailAlreadyExists
    case passwordTooShort
    case invalidNickname    // 닉네임이 2자 이상 8자 이하가 아닌 경우
    
    var message: String {
        switch self {
        case .valid:
            return "회원가입이 완료되었습니다."
        case .invalidEmail:
            return "이메일 주소를 형식에 맞게 입력해주세요."
        case .emailAlreadyExists:
            return "이미 가입한 이메일입니다."
        case .passwordTooShort:
            return "비밀번호는 최소 8자 이상이어야 합니다."
        case .invalidNickname:
            return "닉네임은 2 ~ 8자로 입력해주세요."
        }
    }
}
