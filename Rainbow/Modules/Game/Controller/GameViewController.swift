//
//  GameViewController.swift
//  Rainbow
//
//  Created by Kirill Taraturin on 12.11.2023.
//

import UIKit

class GameViewController: UIViewController {
    
    //MARK: - Properties
    
    private var timer: Timer!
    private var secondsPassed = 0
    
    //MARK: - UI Elements
    
    private lazy var firstColorView = GameView()
    private lazy var secondColorView = GameView()
    private lazy var thirdColorView = GameView()
    private lazy var fourthColorView = GameView()
    private lazy var fifthColorView = GameView()
    private lazy var views = [
        firstColorView,
        secondColorView,
        thirdColorView,
        fourthColorView,
        fifthColorView
    ]
    private lazy var speedButton: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.frame = .zero
        btn.backgroundColor = .red
        btn.widthAnchor.constraint(equalToConstant: 73).isActive = true
        btn.heightAnchor.constraint(equalToConstant: 71).isActive = true
        return btn
        
    }()
    
    //MARK: - Life cylce
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //Call functions
        timeCount(value: 100)
        configureView()
        setupSpeedButton()
        constranints()
    }
    
    //MARK: - Methods
    
    func configureView() {
        //Setup views
        self.view.backgroundColor = .grayBackgroundColor
        self.view.addSubviews(
            firstColorView,
            secondColorView,
            thirdColorView,
            fourthColorView,
            fifthColorView,
            speedButton
        )
        views.forEach { view in
            view.addTarget(target: self, action: #selector(checkButtonTapped))
        }
    }
    
    //MARK: - Private methods
    
    private func timeCount(value: Int) {
        let value = value
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { Timer in
            if self.secondsPassed < value {
                self.secondsPassed += 1
                print(self.secondsPassed)
            } else {
                Timer.invalidate()
            }
        }
    }
    
    private func setupSpeedButton() {
        //Speed button
        speedButton.setTitle("X2", for: .normal)
        speedButton.titleLabel?.font = UIFont.systemFont(ofSize: 25)
        speedButton.layer.cornerRadius = 36
        speedButton.layer.shadowColor = UIColor.black.cgColor
        speedButton.layer.shadowOpacity = 0.8
        speedButton.layer.shadowOffset = CGSizeMake(0, 4)
        speedButton.layer.shadowRadius = 1
    }
    
    //MARK: - @objc methods
    
    @objc func checkButtonTapped(_ sender: UIButton) {
        sender.currentImage == nil ? sender.setImage(UIImage(named: "check"), for: .normal) : sender.setImage(UIImage(named: " "), for: .normal)
    }
}

extension GameViewController {
    
    // Setup constraints
    private func constranints() {
        
        NSLayoutConstraint.activate([
            //First color view
            firstColorView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 68),
            firstColorView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 17),
            firstColorView.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -20),
            firstColorView.heightAnchor.constraint(equalToConstant: 40),
            firstColorView.widthAnchor.constraint(equalToConstant: 238),
            
            //Second color view
            secondColorView.topAnchor.constraint(equalTo: firstColorView.bottomAnchor, constant: 60),
            secondColorView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -21),
            secondColorView.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor, constant: 119),
            secondColorView.heightAnchor.constraint(equalToConstant: 40),
            secondColorView.widthAnchor.constraint(equalToConstant: 238),
            
            //Third color view
            thirdColorView.topAnchor.constraint(equalTo: secondColorView.bottomAnchor, constant: 95),
            thirdColorView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 68),
            thirdColorView.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -102),
            thirdColorView.heightAnchor.constraint(equalToConstant: 40),
            thirdColorView.widthAnchor.constraint(equalToConstant: 238),
            
            //Fourth color view
            fourthColorView.topAnchor.constraint(equalTo: thirdColorView.bottomAnchor, constant: 143),
            fourthColorView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -53),
            fourthColorView.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor),
            fourthColorView.heightAnchor.constraint(equalToConstant: 40),
            fourthColorView.widthAnchor.constraint(equalToConstant: 238),
            
            //Fifth color view
            fifthColorView.topAnchor.constraint(equalTo: fourthColorView.topAnchor, constant: 103),
            fifthColorView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            fifthColorView.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -140),
            fifthColorView.bottomAnchor.constraint(lessThanOrEqualTo: view.bottomAnchor),
            fifthColorView.heightAnchor.constraint(equalToConstant: 40),
            fifthColorView.widthAnchor.constraint(equalToConstant: 238),
            
            //Speed button constaints
            speedButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            speedButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -34),
        ])
    }
}
