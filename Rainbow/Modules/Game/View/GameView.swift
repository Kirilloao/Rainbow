//
//  GameView.swift
//  Rainbow
//
//  Created by Nikita on 14.11.2023.
//

import UIKit

final class GameView: UIView {
    
    //MARK: - Private UI Elements
    private lazy var viewLabel = UILabel()
    private lazy var checkButton = UIButton()
    
    //MARK: - Private Properties
    private var isSubstrate = false
    
    //MARK: - Init
    init(isSubstrate: Bool) {
        super.init(frame: .zero)
        self.isSubstrate = isSubstrate
        setupView()
        constraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Public Methods
    func addTarget(target: Any, action: Selector) {
        checkButton.addTarget(target, action: action, for: .touchUpInside)
    }
    
    func getLabelTextColor() -> UIColor {
        viewLabel.textColor
    }
    
    func changeColorsAndTitle(color: UIColor, title: String, fontSize: CGFloat) {
        checkLetterColor(with: color)
        viewLabel.text = title
        viewLabel.font = UIFont.boldSystemFont(ofSize: fontSize)
        checkButton.setImage(nil, for: .normal)
        checkButton.layer.cornerRadius = 15
    }
    
    func getTitle() -> String {
        viewLabel.text!
    }
    
    //MARK: - Private methods
    private func setupView() {
        self.alpha = 0
        checkButton.layer.cornerRadius = 15
        self.layer.cornerRadius = 10
        self.addSubviews(viewLabel)
        animatedView()
    }
    
    ///Create shadows for each view
    private func makeShadovForView() {
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.8
        self.layer.shadowOffset = CGSizeMake(0, 4)
        self.layer.shadowRadius = 1
    }
    
    ///Create animation for each view
    private func animatedView() {
        UIView.animate(withDuration: 0.5) {
            self.alpha = 1
        }
    }
    
    private func checkLetterColor(with color: UIColor) {
        if isSubstrate {
            self.backgroundColor = color
            viewLabel.textColor = .white
            checkButton.backgroundColor = .white
            makeShadovForView()
        } else {
            self.backgroundColor = .clear
            viewLabel.textColor = color
            checkButton.backgroundColor = .white
        }
    }
}

//MARK: - Constraints
extension GameView {
    
    private func constraints() {
        NSLayoutConstraint.activate([
            viewLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            viewLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            //Check button constaints
            //            checkButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            //            checkButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            //            checkButton.widthAnchor.constraint(equalToConstant: 30),
            //            checkButton.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
}
