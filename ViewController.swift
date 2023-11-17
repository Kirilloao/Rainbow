//
//  ViewController.swift
//  Rules
//
//  Created by Юлия Харитоненко on 14.11.2023.
//

import UIKit


class ViewController: UIViewController {
    
   let myView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
        
   }()
    
    let labelTitle: UILabel = {
        let labelTitle = UILabel()
        labelTitle.text = "ПРАВИЛА ИГРЫ"
        labelTitle.font = UIFont.systemFont(ofSize: 20.0, weight: .bold)
        labelTitle.textColor = .red
        labelTitle.translatesAutoresizingMaskIntoConstraints = false
        labelTitle.textAlignment = .center
        return labelTitle
        
        
    }()
    
    let multiLineLabel: UILabel = {
        let multiLineLabel = UILabel()
        multiLineLabel.font = UIFont.systemFont(ofSize: 17)
        multiLineLabel.translatesAutoresizingMaskIntoConstraints = false
        multiLineLabel.numberOfLines = 0
        let label = """
        На экране в случайном
        месте появляется слово, 
        обозначающее цвет,
        например: написано
        «синий»:
        """
        multiLineLabel.textAlignment = .natural
        let coloredString = "«синий»"
        let rangeOfColoredString = (label as NSString).range(of: coloredString)

        let attributedString = NSMutableAttributedString(string:label)
        attributedString.setAttributes([NSAttributedString.Key.foregroundColor: UIColor.red],
                                      range: rangeOfColoredString)
        multiLineLabel.attributedText = attributedString
        return multiLineLabel
        
    }()
    
    
    let aboveleftLabel: UILabel = {
            let label = UILabel()
            label.text = "подложка выключена"
            label.textAlignment = .center
            label.font = UIFont.systemFont(ofSize: 12.0, weight: .regular)
            label.textColor = .black
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
    
    
    let aboveRightLabel: UILabel = {
            let label = UILabel()
            label.text = "подложка включена"
            label.textAlignment = .center
            label.font = UIFont.systemFont(ofSize: 12.0, weight: .regular)
            label.textColor = .black
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
    
    let leftButton: UIButton = {
            let button = UIButton()
            button.setTitle("cиний", for: .normal)
            button.setTitleColor(UIColor(red: 32/255, green: 203/255, blue: 61/255, alpha: 1), for: .normal)
            button.backgroundColor = .clear
            button.layer.shadowColor = UIColor.black.cgColor
            button.layer.shadowOffset = .init(width: 0, height: 4)
            button.layer.shadowOpacity = 0.25
            button.translatesAutoresizingMaskIntoConstraints = false

            return button
        }()
    
    let RightButton: UIButton = {
            let button = UIButton()
            button.setTitle("Синий", for: .normal)
            button.layer.cornerRadius = 5
            button.backgroundColor = UIColor(red: 32/255, green: 203/255, blue: 61/255, alpha: 1)
            button.layer.shadowColor = UIColor.black.cgColor
            button.layer.shadowOffset = .init(width: 0, height: 4)
            button.layer.shadowOpacity = 0.25
            button.translatesAutoresizingMaskIntoConstraints = false

            return button
        }()
    
    let middleLabel: UILabel = {
        let middleLabel = UILabel()
        middleLabel.font = UIFont.systemFont(ofSize: 17)
        middleLabel.translatesAutoresizingMaskIntoConstraints = false
        middleLabel.numberOfLines = 0
        let label = """
        Нужно произнести вслух
        цвет слова (если опция
        «подложка для букв»
        выключена) или цвет фона,
        на котором написано
        слово (если опция
        «подложка для букв»
        включена):
        говорим «зеленый».
        """
        middleLabel.textAlignment = .natural
        let coloredString = "говорим «зеленый»"
        let rangeOfColoredString = (label as NSString).range(of: coloredString)

        let attributedString = NSMutableAttributedString(string:label)
        attributedString.setAttributes([NSAttributedString.Key.foregroundColor: UIColor.red],
                                      range: rangeOfColoredString)
        middleLabel.attributedText = attributedString
        return middleLabel
        
    }()
    
    let finalLabel: UILabel = {
        let finalLabel = UILabel()
        finalLabel.font = UIFont.systemFont(ofSize: 17)
        finalLabel.translatesAutoresizingMaskIntoConstraints = false
        finalLabel.numberOfLines = 0
        finalLabel.text = """
        В игре можно изменять
        скорость от 1х до 5х.
        А также длительность игры.
        """
        
        return finalLabel
        
    }()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Помощь"
        design()
    
    }
    
        }
        
extension ViewController {
            private func design() {
            view.backgroundColor = .grayBackground
            view.addSubview(myView)
            myView.addSubview(labelTitle)
            myView.addSubview(multiLineLabel)
            myView.addSubview(aboveleftLabel)
            myView.addSubview(aboveRightLabel)
            myView.addSubview(leftButton)
            myView.addSubview(RightButton)
            myView.addSubview(middleLabel)
            myView.addSubview(finalLabel)
        
        NSLayoutConstraint.activate([
            myView.topAnchor.constraint(equalTo: view.topAnchor, constant: 160),
            myView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            myView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            myView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
            
            
            labelTitle.widthAnchor.constraint(equalToConstant: 225),
            labelTitle.heightAnchor.constraint(equalToConstant: 21),
            labelTitle.topAnchor.constraint(equalTo: myView.topAnchor, constant: 22),
            labelTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            multiLineLabel.widthAnchor.constraint(equalToConstant: 263),
            multiLineLabel.heightAnchor.constraint(equalToConstant: 142),
            multiLineLabel.topAnchor.constraint(equalTo: labelTitle.topAnchor, constant: 22),
            multiLineLabel.leadingAnchor.constraint(equalTo: myView.leadingAnchor, constant: 20),
            // multiLineLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            aboveleftLabel.topAnchor.constraint(equalTo: multiLineLabel.bottomAnchor, constant: 10),
            aboveleftLabel.leadingAnchor.constraint(equalTo: myView.leadingAnchor, constant: 20),
            
            aboveRightLabel.topAnchor.constraint(equalTo: multiLineLabel.bottomAnchor, constant: 10),
            aboveRightLabel.trailingAnchor.constraint(equalTo: myView.trailingAnchor, constant: -20),
            
            
            leftButton.topAnchor.constraint(equalTo: aboveleftLabel.bottomAnchor, constant: 10),
            leftButton.leadingAnchor.constraint(equalTo: myView.leadingAnchor, constant: 50),
            
            RightButton.topAnchor.constraint(equalTo: aboveRightLabel.bottomAnchor, constant: 10),
            RightButton.trailingAnchor.constraint(equalTo: myView.trailingAnchor, constant: -50),
            
            middleLabel.topAnchor.constraint(equalTo: leftButton.bottomAnchor, constant: 20),
            middleLabel.leadingAnchor.constraint(equalTo: myView.leadingAnchor, constant: 20),
            
            finalLabel.topAnchor.constraint(equalTo: middleLabel.bottomAnchor, constant: 20),
            finalLabel.leadingAnchor.constraint(equalTo: myView.leadingAnchor, constant: 20)
            ])
    }
  
}



