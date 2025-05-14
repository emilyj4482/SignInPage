//
//  StartView.swift
//  SignInPage
//
//  Created by EMILY on 12/05/2025.
//

import UIKit

protocol StartDelegate: AnyObject {
    func startButtonTapped()
}

class StartView: UIView {
    
    private weak var delegate: StartDelegate?
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        
        label.text = "버튼을 눌러 시작하세요 🙂"
        label.font = .boldSystemFont(ofSize: 25)
        
        return label
    }()
    
    private lazy var startButton: CustomButton = .init(buttonSort: .start)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews([titleLabel, startButton])
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupStartButton(delegate: StartDelegate) {
        startButton.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
        self.delegate = delegate
    }
    
    private func layout() {
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: startButton.topAnchor, constant: -150),
            
            startButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            startButton.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    @objc private func startButtonTapped() {
        delegate?.startButtonTapped()
    }
}
