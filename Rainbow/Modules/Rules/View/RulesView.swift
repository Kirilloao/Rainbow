//
//  RulesView.swift
//  Rainbow
//
//  Created by Kirill Taraturin on 18.11.2023.
//

import UIKit

final class RulesView: UIView {
    
    // MARK: - Private UI Properties
    private let labelTitle: UILabel = {
        let labelTitle = UILabel()
        labelTitle.text = "ПРАВИЛА ИГРЫ"
        labelTitle.font = UIFont.systemFont(ofSize: 20.0, weight: .bold)
        labelTitle.textColor = .red
        labelTitle.translatesAutoresizingMaskIntoConstraints = false
        labelTitle.textAlignment = .center
        return labelTitle
    }()
    
    private let multiLineLabel: UILabel = {
        let multiLineLabel = UILabel()
        multiLineLabel.font = UIFont.systemFont(ofSize: 18)
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
    
    private let aboveleftLabel: UILabel = {
        let label = UILabel()
        label.text = "подложка выключена"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 12.0, weight: .regular)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let aboveRightLabel: UILabel = {
        let label = UILabel()
        label.text = "подложка включена"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 12.0, weight: .regular)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let leftButton: UIButton = {
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
    
    private let RightButton: UIButton = {
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
    
    private let middleLabel: UILabel = {
        let middleLabel = UILabel()
        middleLabel.font = UIFont.systemFont(ofSize: 18)
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
    
    private let finalLabel: UILabel = {
        let finalLabel = UILabel()
        finalLabel.font = UIFont.systemFont(ofSize: 18)
        finalLabel.translatesAutoresizingMaskIntoConstraints = false
        finalLabel.numberOfLines = 0
        finalLabel.text = """
         В игре можно изменять
         скорость от 1х до 5х.
         А также длительность игры.
         """
        return finalLabel
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setViews()
        setupConstraints()
        layer.cornerRadius = 15
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    private func setViews() {
        addSubview(labelTitle)
        addSubview(multiLineLabel)
        addSubview(aboveleftLabel)
        addSubview(aboveRightLabel)
        addSubview(leftButton)
        addSubview(RightButton)
        addSubview(middleLabel)
        addSubview(finalLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            labelTitle.widthAnchor.constraint(equalToConstant: 225),
            labelTitle.heightAnchor.constraint(equalToConstant: 21),
            labelTitle.topAnchor.constraint(equalTo: topAnchor, constant: 22),
            labelTitle.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            multiLineLabel.widthAnchor.constraint(equalToConstant: 263),
            multiLineLabel.heightAnchor.constraint(equalToConstant: 142),
            multiLineLabel.topAnchor.constraint(equalTo: labelTitle.topAnchor, constant: 22),
            multiLineLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            // multiLineLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            aboveleftLabel.topAnchor.constraint(equalTo: multiLineLabel.bottomAnchor, constant: 10),
            aboveleftLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            
            aboveRightLabel.topAnchor.constraint(equalTo: multiLineLabel.bottomAnchor, constant: 10),
            aboveRightLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            leftButton.topAnchor.constraint(equalTo: aboveleftLabel.bottomAnchor, constant: 10),
            leftButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 50),
            
            RightButton.topAnchor.constraint(equalTo: aboveRightLabel.bottomAnchor, constant: 10),
            RightButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -50),
            
            middleLabel.topAnchor.constraint(equalTo: leftButton.bottomAnchor, constant: 20),
            middleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            
            finalLabel.topAnchor.constraint(equalTo: middleLabel.bottomAnchor, constant: 20),
            finalLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20)
        ])
    }
}
