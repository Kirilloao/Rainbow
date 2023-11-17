//
//  AppState + Extensions.swift
//  Rainbow
//
//  Created by Yerlan Omarov on 17.11.2023.
//

import Foundation

extension AppState: SettingsDataSource {
    func getSettings() -> Settings {
        if let data = defaults.loadObject(type: Settings.self, for: .settings)  {
            return data
        }
        return defaultSettings
    }

    func saveSettings(_ settings: Settings) {
        defaults.saveObject(object: settings, for: .settings)
    }
}

extension AppState: StatisticsDataSource {
    func addGame(_ game: ResultsCardModel) {
        games.append(game)
        saveGames()
    }
    
    func saveGames() {
        defaults.saveObject(object: [games], for: .results)
    }
    
    func getGames() -> [ResultsCardModel] {
        games
    }
    
    func removeGames() {
        games.removeAll()
        saveGames()
    }
}
