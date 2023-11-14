//
//  GameView.swift
//  Rainbow
//
//  Created by Nikita on 14.11.2023.
//

import UIKit

class GameView: UIView {
    
    //MARK: - Properties
    
    private lazy var viewLabel = UILabel()
    private lazy var checkButton = UIButton()
    var viewsColor = [UIColor.red, UIColor.blue, UIColor.purple, UIColor.yellow, UIColor.green] // сделать словарь ключ значение для цвета
    var viewsTitle = ["Красный", "Синий", "Фиолетовый", "Желтый", "Зеленый"]
    
    //MARK: - Life cycle
    
    init() {
        super.init(frame: .zero)
        setupView()
        constraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Methods
    
    func setupView() {
        
        //        перенести в контроллер
        //        var views = [UIView(), UIView(), UIView(), UIView(), UIView()]
        //        self.views.forEach { view in
        //            view.addSubviews(label, checkButton)
        //            label.text = viewsTitle.randomElement()
        //            view.backgroundColor = viewsColor.randomElement()
        //        }
        
        self.layer.cornerRadius = 10
        self.backgroundColor = viewsColor.randomElement()
        self.addSubviews(viewLabel, checkButton)
        viewLabel.text = self.viewsTitle.randomElement()
        checkButton.setImage(UIImage(named: "noCheck"), for: .normal)
        checkButton.addTarget(self, action: #selector(checkButtonTapped), for: .touchUpInside)
    }
    
    @objc func checkButtonTapped() {
        let tapCount = 0
        if tapCount.isMultiple(of: 2) {
            checkButton.addSubview(UIImageView(image: UIImage(named: "check")!))
        }
    }
}


extension GameView {
    
    func constraints() {
        NSLayoutConstraint.activate([
            // Label constraints
            viewLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            viewLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            //Check button constaints
            checkButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            checkButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10)
        ])
    }
}
