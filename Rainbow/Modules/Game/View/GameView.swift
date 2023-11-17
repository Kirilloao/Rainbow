//
//  GameView.swift
//  Rainbow
//
//  Created by Nikita on 14.11.2023.
//

import UIKit

class GameView: UIView {
    
    //MARK: - UI Elements
    
    private lazy var viewLabel = UILabel()
    private lazy var checkButton = UIButton()
    
    //MARK: - Properties

    private var letterColor = false
    private lazy var viewsColor = [
        UIColor.redGameColor,
        UIColor.blueGameColor,
        UIColor.purpleGameColor,
        UIColor.yellowGameColor,
        UIColor.greenGameColor,
        UIColor.redGameColor,
        UIColor.blueGameColor,
        UIColor.purpleGameColor,
        UIColor.yellowGameColor,
        UIColor.greenGameColor,
        UIColor.redGameColor,
        UIColor.blueGameColor,
        UIColor.purpleGameColor,
        UIColor.yellowGameColor,
        UIColor.greenGameColor,
    ]
    private lazy var viewsTitle = [
        "Красный",
        "Синий",
        "Фиолетовый",
        "Желтый",
        "Зеленый",
        "Красный",
        "Синий",
        "Фиолетовый",
        "Желтый",
        "Зеленый",
        "Красный",
        "Синий",
        "Фиолетовый",
        "Желтый",
        "Зеленый"
    ]
    
    //MARK: - Life cycle
    
    init(letterColor: Bool) {
        super.init(frame: .zero)
        self.letterColor = letterColor
        
        //Call functions
        setupView()
        constraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Methods
    
    func addTarget(target: Any, action: Selector) {
        checkButton.addTarget(target, action: action, for: .touchUpInside)
    }
    
    func changeColorsAndTitle() {
    
        checkLetterColor()
        viewLabel.text = viewsTitle.randomElement()
        checkButton.setImage(nil, for: .normal)
    }
    
    //MARK: - Private methods
    
    private func setupView() {
        //Setup view
        self.alpha = 0
        checkLetterColor()
        self.layer.cornerRadius = 10
        self.addSubviews(viewLabel, checkButton)
        
        //Setup label
        viewLabel.text = viewsTitle.randomElement()
        viewLabel.font = UIFont.boldSystemFont(ofSize: 25)
        
        //Setup button
        checkButton.layer.cornerRadius = 15
        
        //Call functions
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
    
    private func checkLetterColor() {
        if letterColor {
            self.backgroundColor = viewsColor.randomElement()
            checkButton.backgroundColor = .white
            makeShadovForView()
        } else {
            self.backgroundColor = .clear
            viewLabel.textColor = viewsColor.randomElement()
            checkButton.backgroundColor = .white
        }
    }
}

//MARK: - Extension

extension GameView {
    
    // Setup constraints
    private func constraints() {
        
        NSLayoutConstraint.activate([
            // View label constraints
            viewLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            viewLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            //Check button constaints
            checkButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            checkButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            checkButton.widthAnchor.constraint(equalToConstant: 30),
            checkButton.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
}
