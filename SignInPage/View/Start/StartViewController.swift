//
//  StartViewController.swift
//  SignInPage
//
//  Created by EMILY on 12/05/2025.
//

import UIKit

class StartViewController: UIViewController {
    
    private let containerView: StartView = .init()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView(with: containerView)
        setupStartButton()
    }
    
    private func setupStartButton() {
        containerView.setupStartButton(delegate: self)
    }
}

extension StartViewController: StartDelegate {
    func startButtonTapped() {
        // let vc = SignedInViewController()
        let vc = SignUpViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}
