//
//  ResultsViewController.swift
//  Rainbow
//
//  Created by Kirill Taraturin on 12.11.2023.
//

import UIKit

class ResultsViewController: UIViewController {
    private let tableView = ResultsTableView()
    private let cleanButton: UIButton!
    
    let model: ResultsDataSource
    
    init(model: ResultsDataSource) {
        self.model = model
        self.cleanButton = UIButton(title: model.buttonTitle, backgroundColor: .redGameColor, cornerRadius: 10)
        cleanButton.titleLabel?.font = .systemFont(ofSize: 20)
        cleanButton.dropShadow()
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = model.title
        
        setupTableView()
        setupButton()
    }
    
    private func setupTableView() {
        tableView.backgroundColor = .grayBackgroundColor
        tableView.separatorStyle = .none
        
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        tableView.register(ResultsTableViewCell.self, forCellReuseIdentifier: ResultsTableViewCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
      }
    
    private func setupButton() {
        view.addSubview(cleanButton)
        cleanButton.translatesAutoresizingMaskIntoConstraints = false
        cleanButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 51).isActive = true
        cleanButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -51).isActive = true
        cleanButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -51).isActive = true
        cleanButton.heightAnchor.constraint(equalToConstant: 63).isActive = true
        
        cleanButton.addTarget(self, action: #selector(cleanAction), for: .touchUpInside)
    }
    
    @objc private func cleanAction() {
        
    }
}
