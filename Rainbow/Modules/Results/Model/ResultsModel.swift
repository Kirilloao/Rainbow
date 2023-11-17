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
}

final class ResultsModel: ResultsDataSource {
    private let dataSource: StatisticsDataSource
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
    
    init(dataSource: StatisticsDataSource) {
        self.dataSource = dataSource
        self.statistics = dataSource.getGames()
    }
    
    func removeStatistics() {
        statistics.removeAll()
        dataSource.removeGames()
    }
}
