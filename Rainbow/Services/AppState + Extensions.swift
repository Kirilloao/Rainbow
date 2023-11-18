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
    var count: Int {
        games.count
    }
    
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

extension AppState: GameState {
    func saveGame(_ game: Save) {
        defaults.saveObject(object: game, for: .save)
        
    }
    
    func getGame() -> Save? {
        defaults.loadObject(type: Save.self, for: .save)
    }
    
    
}
