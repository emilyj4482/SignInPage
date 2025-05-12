//
//  SignUpViewController.swift
//  SignInPage
//
//  Created by EMILY on 13/05/2025.
//

import UIKit

class SignUpViewController: UIViewController {
    
    private let containerView: SignUpView = .init()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView(with: containerView)
    }
}
