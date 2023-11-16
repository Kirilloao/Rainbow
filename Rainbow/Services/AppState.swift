//
//  AppState.swift
//  Rainbow
//
//  Created by Kirill Taraturin on 16.11.2023.
//

import Foundation

final class AppState {
    static let shared = AppState()
    
    private let defaults = UserDefaultsManager.shared
    private let defaultSettings = Settings(gameTime: 2, speed: 5, isSubstrate: false)
    private var games = [ResultsCardModel]()
    
    private init() {}
    
    // MARK: - Settings Methods
    func getSettings() -> Settings {
        if let data = defaults.loadObject(type: Settings.self, for: .settings)  {
            return data
        }
        return defaultSettings
    }
    
    func saveSettings(_ settings: Settings) {
        defaults.saveObject(object: settings, for: .settings)
    }
    
    // MARK: - Stat Methods
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
}
