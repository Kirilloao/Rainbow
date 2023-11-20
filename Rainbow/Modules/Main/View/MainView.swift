//
//  MainView.swift
//  Rainbow
//
//  Created by macbook on 13.11.2023.
//

import UIKit

enum ButtonType {
    case newgame, statistic, settings, rules, resume
}

final class MainView: UIView {
    
    // MARK: - Private UI Properties
    private let rainbowImageView = UIImageView(image: UIImage(named: "rainbowImage"))
    private let titleLabel = UILabel(
        text: "НЛП Игра",
        font: .systemFont(ofSize: 32)
    )
    private let gameLabel = UILabel(
        text: "Радуга",
        font: .systemFont(ofSize: 54)
    )
    private let newGame = UIButton(
        title: "Новая игра",
        backgroundColor: .redButtonColor,
        cornerRadius: 10
    )
    private let statistic = UIButton(
        title: "Статистика",
        backgroundColor: .greenButtonColor,
        cornerRadius: 10
    )
    private let resume = UIButton(
        title: "Продолжить",
        backgroundColor: .blueButtonColor,
        cornerRadius: 10
    )
    private let settings = UIButton(image: "settings")
    private let rules = UIButton(image: "rules")
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods
    
    func addTarget(to button: ButtonType, target: Any, action: Selector) {
        switch button {
            
        case .newgame:
            newGame.addTarget(target, action: action, for: .touchUpInside)
        case .statistic:
            statistic.addTarget(target, action: action, for: .touchUpInside)
        case .settings:
            settings.addTarget(target, action: action, for: .touchUpInside)
        case .rules:
            rules.addTarget(target, action: action, for: .touchUpInside)
        case .resume:
            resume.addTarget(target, action: action, for: .touchUpInside)
        }
    }
    
    func toggleResumeButton(isEnabled: Bool) {
        resume.isEnabled = isEnabled
    }
    
    // MARK: - Private Methods
    private func setupView() {
        self.addSubviews(
            rainbowImageView,
            titleLabel,
            gameLabel,
            newGame, statistic,
            settings,
            rules,
            resume
        )
        self.backgroundColor = .grayBackgroundColor
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            rainbowImageView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 20),
            rainbowImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: rainbowImageView.bottomAnchor, constant: 12),
            titleLabel.centerXAnchor.constraint(equalTo: rainbowImageView.centerXAnchor),
            
            gameLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            gameLabel.centerXAnchor.constraint(equalTo: titleLabel.centerXAnchor),
            
            newGame.topAnchor.constraint(equalTo: gameLabel.bottomAnchor, constant: 34),
            newGame.centerXAnchor.constraint(equalTo: gameLabel.centerXAnchor),
            newGame.heightAnchor.constraint(equalToConstant: 65),
            newGame.widthAnchor.constraint(equalToConstant: 285),
            
            resume.topAnchor.constraint(equalTo: newGame.bottomAnchor, constant: 20),
            resume.centerXAnchor.constraint(equalTo: newGame.centerXAnchor),
            resume.heightAnchor.constraint(equalTo: newGame.heightAnchor),
            resume.widthAnchor.constraint(equalTo: newGame.widthAnchor),
            
            statistic.topAnchor.constraint(equalTo: resume.bottomAnchor, constant: 20),
            statistic.centerXAnchor.constraint(equalTo: resume.centerXAnchor),
            statistic.heightAnchor.constraint(equalTo: resume.heightAnchor),
            statistic.widthAnchor.constraint(equalTo: resume.widthAnchor),
            statistic.bottomAnchor.constraint(lessThanOrEqualTo: settings.topAnchor, constant: -40),
            
            settings.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            settings.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 28),
            settings.heightAnchor.constraint(equalToConstant: 50),
            settings.widthAnchor.constraint(equalTo: settings.heightAnchor),
            
            rules.bottomAnchor.constraint(equalTo: settings.bottomAnchor),
            rules.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -28),
            rules.heightAnchor.constraint(equalTo: settings.heightAnchor),
            rules.widthAnchor.constraint(equalTo: rules.heightAnchor)
        ])
    }
}
