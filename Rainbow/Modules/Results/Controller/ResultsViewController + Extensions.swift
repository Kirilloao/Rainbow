//
//  ResultsViewController + Extensions.swift
//  Rainbow
//
//  Created by Yerlan Omarov on 14.11.2023.
//

import UIKit

// MARK: - UITableViewDataSource
extension ResultsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ResultsTableViewCell.identifier, for: indexPath)
                as? ResultsTableViewCell
        else {
            return ResultsTableViewCell()
        }
        
        let cellData = model.results[indexPath.row]
        cell.selectionStyle = .none
        cell.setupView(with: cellData)
        return cell
    }
}

// MARK: - UITableViewDelegate
extension ResultsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }
}
