//
//  Protocols.swift
//  Rainbow
//
//  Created by Yerlan Omarov on 17.11.2023.
//

import Foundation

typealias GameDataSource = SettingsDataSource & StatisticsDataSource

protocol SettingsDataSource {
    func getSettings() -> Settings
    func saveSettings(_ settings: Settings)
}

protocol StatisticsDataSource {
    func addGame(_ game: ResultsCardModel)
    func saveGames()
    func getGames() -> [ResultsCardModel]
    func removeGames()
}
