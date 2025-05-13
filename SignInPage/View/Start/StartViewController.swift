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

extension StartViewController: StartButtonDelegate {
    func startButtonTapped() {
        let vc = SignedInViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}
