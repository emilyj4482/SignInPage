//
//  StartView.swift
//  SignInPage
//
//  Created by EMILY on 12/05/2025.
//

import UIKit

protocol StartButtonDelegate: AnyObject {
    func startButtonTapped()
}

class StartView: UIView {
    
    private weak var delegate: StartButtonDelegate?
    
    private lazy var startButton: UIButton = {
        let button = UIButton()
        
        button.setTitle("시작하기", for: .normal)
        button.setTitleColor(.systemBackground, for: .normal)
        button.backgroundColor = .systemMint
        button.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews([startButton])
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        startButton.layer.cornerRadius = startButton.bounds.width / 15
    }
    
    func setDelegate(delegate: StartButtonDelegate) {
        self.delegate = delegate
    }
    
    private func layout() {
        NSLayoutConstraint.activate([
            startButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            startButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            startButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5),
            startButton.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.08)
        ])
    }
    
    @objc private func startButtonTapped() {
        delegate?.startButtonTapped()
    }
}
