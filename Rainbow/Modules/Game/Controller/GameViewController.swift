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
    private lazy var firstColorView = GameView()
    private lazy var secondColorView = GameView()
    private lazy var thirdColorView = GameView()
    private lazy var fourthColorView = GameView()
    private lazy var fifthColorView = GameView()
    private lazy var speedButton: UIButton = {
       let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.frame = .zero
        btn.backgroundColor = .red
        btn.widthAnchor.constraint(equalToConstant: 73).isActive = true
        btn.heightAnchor.constraint(equalToConstant: 71).isActive = true
        return btn
        
    }()
    private lazy var timerLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.frame = .zero
        lbl.font = .boldSystemFont(ofSize: 25)
        lbl.textAlignment = .center
        return lbl
    }()
    
    
    //MARK: - Life cylce
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        timeCount(value: 100)
        
        //Call functions
        configureView()
        constranints()
        
        DispatchQueue.main.async {
            self.timerLabel.text = "\(self.secondsPassed)"
        }
    }
    
    //MARK: - Methods
    
    func configureView() {
        self.view.backgroundColor = .grayBackgroundColor
        self.view.addSubviews(firstColorView, secondColorView, thirdColorView, fourthColorView, fifthColorView, speedButton, timerLabel)
        
        //Speed button
        speedButton.setTitle("X2", for: .normal)
        speedButton.titleLabel?.font = UIFont.systemFont(ofSize: 25)
        speedButton.layer.cornerRadius = 36
        speedButton.layer.shadowColor = UIColor.black.cgColor
        speedButton.layer.shadowOpacity = 0.8
        speedButton.layer.shadowOffset = CGSizeMake(0, 4)
        speedButton.layer.shadowRadius = 1
        
        //Timer label
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
}

extension GameViewController {
    
    func constranints() {
        
        NSLayoutConstraint.activate([
            firstColorView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            firstColorView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 80),
            firstColorView.heightAnchor.constraint(equalToConstant: 40),
            firstColorView.widthAnchor.constraint(equalToConstant: 238),
            
            secondColorView.topAnchor.constraint(equalTo: view.topAnchor, constant: 200),
            secondColorView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 80),
            secondColorView.heightAnchor.constraint(equalToConstant: 40),
            secondColorView.widthAnchor.constraint(equalToConstant: 238),
            
            thirdColorView.topAnchor.constraint(equalTo: view.topAnchor, constant: 300),
            thirdColorView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 80),
            thirdColorView.heightAnchor.constraint(equalToConstant: 40),
            thirdColorView.widthAnchor.constraint(equalToConstant: 238),
            
            
            fourthColorView.topAnchor.constraint(equalTo: view.topAnchor, constant: 400),
            fourthColorView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 80),
            fourthColorView.heightAnchor.constraint(equalToConstant: 40),
            fourthColorView.widthAnchor.constraint(equalToConstant: 238),
            
            
            fifthColorView.topAnchor.constraint(equalTo: view.topAnchor, constant: 500),
            fifthColorView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 80),
            fifthColorView.heightAnchor.constraint(equalToConstant: 40),
            fifthColorView.widthAnchor.constraint(equalToConstant: 238),
            
            //Speed button constaints
            speedButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            speedButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -34),
        
            //Timer label
            timerLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 260),
            timerLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            timerLabel.widthAnchor.constraint(equalToConstant: 200),
            timerLabel.heightAnchor.constraint(equalToConstant: 50)
        
        ])
    }
}

#Preview {
    GameViewController()
}
