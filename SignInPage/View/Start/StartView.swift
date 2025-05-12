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
    
    weak var delegate: StartButtonDelegate?
    
    private lazy var startButton: UIButton = {
        let button = UIButton()
        
        button.setTitle("시작하기", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setDelegate(delegate: StartButtonDelegate) {
        self.delegate = delegate
    }
    
    private func addSubviews() {
        translatesAutoresizingMaskIntoConstraints = false
        startButton.translatesAutoresizingMaskIntoConstraints = false
        
        addSubviews([startButton])
    }
    
    private func layout() {
        backgroundColor = .systemBackground
        
        NSLayoutConstraint.activate([
            startButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            startButton.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
    
    @objc private func startButtonTapped() {
        delegate?.startButtonTapped()
    }
}
