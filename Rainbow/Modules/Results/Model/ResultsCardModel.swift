//
//  ResultsCardModel.swift
//  Rainbow
//
//  Created by Yerlan Omarov on 14.11.2023.
//

import Foundation

struct ResultsCardModel {
    let gameId: Int
    let seconds: Double
    let speedRate: Int
    let rightCount: Int
    let totalCount: Int
    
    var gameLabelText: String {
        "игра №\(gameId)"
    }
    
    var scoreLabelText: String {
        "угадано \(rightCount)/\(totalCount)"
    }
    
    var timeLabelText: String {
        "время \(seconds)"
    }
    
    var speedRateLabelText: String {
        "скорость х\(speedRate)"
    }
}
