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
}

struct ResultsModel: ResultsDataSource {
    private var statistics: [ResultsCardModel]
    
    let title = "Статистика"
    let buttonTitle = "Очистить статистику"
    
    var results: [ResultsCardModel] {
        statistics
    }
    
    var count: Int {
        statistics.count
    }
    
    init(statistics: [ResultsCardModel]) {
        self.statistics = statistics
    }
}
