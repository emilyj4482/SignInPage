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
        configureUI(with: containerView)
        setDelegate()
    }
    
    private func setDelegate() {
        containerView.setDelegate(delegate: self)
    }
}

extension StartViewController: StartButtonDelegate {
    func startButtonTapped() {
        let vc = SignedInViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}
