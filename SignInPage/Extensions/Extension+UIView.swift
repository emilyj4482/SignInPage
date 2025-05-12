//
//  Extension+UIView.swift
//  SignInPage
//
//  Created by EMILY on 12/05/2025.
//

import UIKit

extension UIView {
    func setupSubviews(_ views: [UIView]) {
        views.forEach {
            self.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
}
