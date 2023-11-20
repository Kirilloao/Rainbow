//
//  AppState + Extensions.swift
//  Rainbow
//
//  Created by Yerlan Omarov on 17.11.2023.
//

import UIKit

// MARK: - SettingsDataSource
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
    
    var colors: [UIColor] {
        buttonColors
    }
}

// MARK: - StatisticsDataSource
extension AppState: StatisticsDataSource {
    var count: Int {
        games.count
    }
    
    func addGame(_ game: ResultsCardModel) {
        games.append(game)
        saveGames()
    }
    
    func saveGames() {
        defaults.saveObject(object: games, for: .results)
    }
    
    func getGames() -> [ResultsCardModel] {
        guard games.isEmpty else { return games }
        games = defaults.loadObject(type: [ResultsCardModel].self, for: .results) ?? []
        return games
    }
    
    func removeGames() {
        games.removeAll()
        saveGames()
    }
}

// MARK: - GameState
extension AppState: GameState {
    func saveGame(_ game: Save) {
        defaults.saveObject(object: game, for: .save)
    }
    
    func getGame() -> Save? {
        defaults.loadObject(type: Save.self, for: .save)
    }
    
    func deleteSavedGames() {
        defaults.deleteObject(for: .save)
    }
}
