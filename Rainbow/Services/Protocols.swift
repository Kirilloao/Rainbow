//
//  Protocols.swift
//  Rainbow
//
//  Created by Yerlan Omarov on 17.11.2023.
//

import UIKit

typealias GameDataSource = SettingsDataSource & StatisticsDataSource & GameState

protocol SettingsDataSource {
    func getSettings() -> Settings
    func saveSettings(_ settings: Settings)
    
    var colors: [UIColor] { get }
}

protocol StatisticsDataSource {
    func addGame(_ game: ResultsCardModel)
    func saveGames()
    func getGames() -> [ResultsCardModel]
    func removeGames()
    var count: Int { get }
}

protocol GameState {
    func saveGame(_ game: Save)
    func getGame() -> Save?
    func deleteSavedGames()
}


