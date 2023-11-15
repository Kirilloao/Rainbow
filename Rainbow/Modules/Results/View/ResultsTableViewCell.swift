//
//  ResultsTableViewCell.swift
//  Rainbow
//
//  Created by Yerlan Omarov on 14.11.2023.
//

import UIKit

class ResultsTableViewCell: UITableViewCell {
    static let identifier = "ResultsTableViewCell"
    
    private var containerView = ResultsCardView()
    
    func setupView(with model: ResultsCardModel) {
        containerView.setModel(with: model)
        
        setupContentView()
        setupConstraints()
    }
    
    private func setupContentView() {
        containerView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(containerView)
        contentView.backgroundColor = .grayBackgroundColor
        
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 33),
            containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -33),
        ])
    }
}
