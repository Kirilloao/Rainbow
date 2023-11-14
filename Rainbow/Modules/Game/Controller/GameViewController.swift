//
//  GameViewController.swift
//  Rainbow
//
//  Created by Kirill Taraturin on 12.11.2023.
//

import UIKit

class GameViewController: UIViewController {
    
    //MARK: - Properties
    
    var gameView = GameView()
    var gameView1 = GameView()
    var gameView2 = GameView()
    var gameView3 = GameView()
    var gameView4 = GameView()
    lazy var views = [self.gameView, self.gameView1, self.gameView2, self.gameView3, self.gameView4]
    
    //MARK: - Life cylce
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Call functions
        configureView()
        constranints()
    }
    
    //MARK: - Methods
    
    func configureView() {
        self.view.backgroundColor = .grayBackgroundColor
        self.view.addSubviews(gameView, gameView1, gameView2, gameView3, gameView4)
    }
}

extension GameViewController {
    
    func constranints() {
        
        NSLayoutConstraint.activate([
            gameView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            gameView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 80),
            gameView.heightAnchor.constraint(equalToConstant: 40),
            gameView.widthAnchor.constraint(equalToConstant: 238),
            
            gameView1.topAnchor.constraint(equalTo: view.topAnchor, constant: 200),
            gameView1.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 80),
            gameView1.heightAnchor.constraint(equalToConstant: 40),
            gameView1.widthAnchor.constraint(equalToConstant: 238),
            
            gameView2.topAnchor.constraint(equalTo: view.topAnchor, constant: 300),
            gameView2.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 80),
            gameView2.heightAnchor.constraint(equalToConstant: 40),
            gameView2.widthAnchor.constraint(equalToConstant: 238),
            
            
            gameView3.topAnchor.constraint(equalTo: view.topAnchor, constant: 400),
            gameView3.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 80),
            gameView3.heightAnchor.constraint(equalToConstant: 40),
            gameView3.widthAnchor.constraint(equalToConstant: 238),
            
            
            gameView4.topAnchor.constraint(equalTo: view.topAnchor, constant: 500),
            gameView4.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 80),
            gameView4.heightAnchor.constraint(equalToConstant: 40),
            gameView4.widthAnchor.constraint(equalToConstant: 238)
        ])
    }
}

#Preview {
    GameViewController()
}
