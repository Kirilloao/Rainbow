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
        
        guard let random = views.randomElement() else { return } 
        
        NSLayoutConstraint.activate([
            random.topAnchor.constraint(equalTo: view.topAnchor),
            random.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            random.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            random.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        
    }
}

#Preview {
    GameViewController()
}
