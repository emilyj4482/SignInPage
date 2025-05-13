//
//  Extension+UIStackView.swift
//  SignInPage
//
//  Created by EMILY on 13/05/2025.
//

import UIKit

extension UIStackView {
    func setupArrangedSubviews(_ views: [UIView]) {
        views.forEach {
            self.addArrangedSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
}
