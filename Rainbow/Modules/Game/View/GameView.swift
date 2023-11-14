//
//  GameView.swift
//  Rainbow
//
//  Created by Nikita on 14.11.2023.
//

import UIKit

class GameView: UIView {
    
    //MARK: - Properties
    
    private lazy var label = UILabel()
    private lazy var checkButton = UIButton()
    var viewsColor = [UIColor.red, UIColor.blue, UIColor.purple, UIColor.yellow, UIColor.green] // сделать словарь ключ значение для цвета
    var viewsTitle = ["Красный", "Синий", "Фиолетовый", "Желтый", "Зеленый"]
    
    //MARK: - Life cycle
    
    init() {
        super.init(frame: .zero)
        setupView()
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
        

        self.backgroundColor = viewsColor.randomElement()
        self.addSubviews(label, checkButton)
        label.text = self.viewsTitle.randomElement()
        checkButton.setImage(UIImage(named: "noCheck"), for: .normal)
        checkButton.addSubview(UIImageView(image: UIImage(named: "check")!))
    }
}
