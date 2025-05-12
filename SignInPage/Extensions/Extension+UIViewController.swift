//
//  Extension+UIViewController.swift
//  SignInPage
//
//  Created by EMILY on 13/05/2025.
//

import UIKit

extension UIViewController {
    func configureUI(with containerView: UIView) {
        view.backgroundColor = .systemBackground
        
        view.addSubview(containerView)
        
        containerView.backgroundColor = .systemBackground
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        let safeArea = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
        ])
    }
}
