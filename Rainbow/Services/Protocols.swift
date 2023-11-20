//
//  Protocols.swift
//  Rainbow
//
//  Created by Yerlan Omarov on 17.11.2023.
//

import UIKit

// MARK: - Typealias
typealias GameDataSource = SettingsDataSource & StatisticsDataSource & GameState

// MARK: - SettingsDataSource
protocol SettingsDataSource {
    var colors: [UIColor] { get }
    
    func getSettings() -> Settings
    func saveSettings(_ settings: Settings)
}

// MARK: - StatisticsDataSource
protocol StatisticsDataSource {
    func addGame(_ game: ResultsCardModel)
    func saveGames()
    func getGames() -> [ResultsCardModel]
    func removeGames()
    var count: Int { get }
}

// MARK: - GameState
protocol GameState {
    func saveGame(_ game: Save)
    func getGame() -> Save?
    func deleteSavedGames()
}


