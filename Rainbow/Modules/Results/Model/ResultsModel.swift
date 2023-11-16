//
//  ResultsModel.swift
//  Rainbow
//
//  Created by Yerlan Omarov on 14.11.2023.
//

import Foundation

protocol ResultsDataSource {
    var title: String { get }
    var buttonTitle: String { get }
    var results: [ResultsCardModel] { get }
    var count: Int { get }
    var isEmpty: Bool { get }
    
    func removeStatistics()
    func updateStatistics(with statistics: [ResultsCardModel])
}

class ResultsModel: ResultsDataSource {
    private var statistics: [ResultsCardModel]
    
    let title = "Статистика"
    let buttonTitle = "Очистить статистику"
    
    var results: [ResultsCardModel] {
        statistics
    }
    
    var count: Int {
        statistics.count
    }
    
    var isEmpty: Bool {
        statistics.isEmpty
    }
    
    init(statistics: [ResultsCardModel]) {
        self.statistics = statistics
    }
    
    func removeStatistics() {
        statistics.removeAll()
        // TODO: - delete from app state
    }
    
    func updateStatistics(with statistics: [ResultsCardModel]) {
        self.statistics = statistics
        // TODO: - update in app state
    }
}
