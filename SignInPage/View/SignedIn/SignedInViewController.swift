//
//  SignedInViewController.swift
//  SignInPage
//
//  Created by EMILY on 13/05/2025.
//

import UIKit

class SignedInViewController: UIViewController {
    
    private let containerView: SignedInView = .init()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView(with: containerView)
        containerView.configureSubviews(with: "에밀리")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.setNeedsLayout()
    }
}
