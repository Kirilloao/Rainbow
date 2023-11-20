//
//  ResultsTableViewCell.swift
//  Rainbow
//
//  Created by Yerlan Omarov on 14.11.2023.
//

import UIKit

final class ResultsTableViewCell: UITableViewCell {
    
    // MARK: - Static Properties
    static let identifier = "ResultsTableViewCell"
    
    // MARK: - Private Properties
    private var containerView = ResultsCardView()
    
    // MARK: - Publc Methods
    func setupView(with model: ResultsCardModel) {
        containerView.setModel(with: model)
        
        setupContentView()
        setupConstraints()
    }
    
    // MARK: - Private Methods
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
