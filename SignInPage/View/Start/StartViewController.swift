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
        setDelegate()
        setupUI()
    }
    
    private func setDelegate() {
        containerView.setDelegate(delegate: self)
    }
    
    private func setupUI() {
        view.addSubview(containerView)
        
        let safeArea = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
        ])
    }
}

extension StartViewController: StartButtonDelegate {
    func startButtonTapped() {
        print("start button tapped")
    }
}
