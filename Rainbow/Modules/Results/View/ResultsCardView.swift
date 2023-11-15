//
//  ResultsCardView.swift
//  Rainbow
//
//  Created by Yerlan Omarov on 14.11.2023.
//

import UIKit

class ResultsCardView: UIView {
    private var model: ResultsCardModel!
    
    // MARK: - private UI properties
    private lazy var gameLabel: UILabel = UILabel(
        text: model.gameLabelText,
        font: .systemFont(ofSize: 20),
        color: .pinkLabelColor
    )
    
    private lazy var timeLabel: UILabel = UILabel(
        text: model.timeLabelText,
        font: .systemFont(ofSize: 20)
    )
    
    private lazy var speedRateLabel: UILabel = UILabel(
        text: model.speedRateLabelText,
        font: .systemFont(ofSize: 20)
    )
    
    private lazy var scoreLabel: UILabel = UILabel(
        text: model.scoreLabelText,
        font: .systemFont(ofSize: 20, weight: .bold),
        color: .greenGameColor
    )
    
    private lazy var firstColumn: UIStackView = {
        let firstColumn = UIStackView(arrangedSubviews: [gameLabel, timeLabel])
        firstColumn.axis = .vertical
        firstColumn.alignment = .leading
        firstColumn.distribution = .fillEqually
        firstColumn.translatesAutoresizingMaskIntoConstraints = false
        firstColumn.layoutMargins = UIEdgeInsets(top: 9, left: 9, bottom: 9, right: 9)
        firstColumn.isLayoutMarginsRelativeArrangement = true
        
        return firstColumn
    }()
    
    private lazy var secondColumn: UIStackView = {
        let secondColumn = UIStackView(arrangedSubviews: [speedRateLabel, scoreLabel])
        secondColumn.axis = .vertical
        secondColumn.alignment = .trailing
        secondColumn.distribution = .fillEqually
        secondColumn.translatesAutoresizingMaskIntoConstraints = false
        secondColumn.layoutMargins = UIEdgeInsets(top: 9, left: 9, bottom: 9, right: 9)
        secondColumn.isLayoutMarginsRelativeArrangement = true
        
        return secondColumn
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [firstColumn, secondColumn])
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    
    // MARK: - initializers
    init() {
        self.model = .init(gameId: 0, seconds: 0, speedRate: 0, rightCount: 0, totalCount: 0)
        super.init(frame: CGRect())
        
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - view setup
    func setModel(with model: ResultsCardModel) {
        self.model = model
        gameLabel.text = model.gameLabelText
        scoreLabel.text = model.scoreLabelText
        timeLabel.text = model.timeLabelText
        speedRateLabel.text = model.speedRateLabelText
    }
    
    // MARK: - private methods
    private func setupView() {
        self.backgroundColor = .white
        self.dropShadow()
        self.layer.cornerRadius = 10
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0),
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
            
            firstColumn.topAnchor.constraint(equalTo: stackView.topAnchor, constant: 0),
            firstColumn.bottomAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 0),
            firstColumn.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 0),
            
            secondColumn.topAnchor.constraint(equalTo: stackView.topAnchor, constant: 0),
            secondColumn.bottomAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 0),
            secondColumn.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: 0),
        ])
    }
}
