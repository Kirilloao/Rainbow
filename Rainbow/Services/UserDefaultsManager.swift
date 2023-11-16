//
//  UserDefaultsManager.swift
//  Rainbow
//
//  Created by Kirill Taraturin on 16.11.2023.
//

import Foundation

enum Key: String {
    case gameTime = "GameTime"
    case speed = "Speed"
    case check = "Check"
    case letterColors = "LetterColors"
    case letterSize = "LetterSize"
    case substrate = "Substrate"
    case backgroundColor = "BackgroundColor"
    case wordsLocation = "WordsLocation"
    case currentGameTime = "CurrentGameTime"
}

final class UserDefaultsManager {
    static let shared = UserDefaultsManager()
    
    private let defaults = UserDefaults.standard
    
    private init() {}
    
    // MARK: - Save Methods
    func save<T>(value: T.Type, key: Key) {
        defaults.set(value, forKey: key.rawValue)
    }
    
    func saveObject<T: Encodable>(object: T, for key: Key) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(object) {
            defaults.set(encoded, forKey: key.rawValue)
        }
    }
    
    // MARK: - Load Methods
    func load<T>(type: T.Type, for key: Key) -> T? {
        defaults.object(forKey: key.rawValue) as? T
    }
    
    func loadObject<T: Decodable>(type: T.Type, for key: Key) -> T? {
        if let data = defaults.data(forKey: key.rawValue) {
            let decoder = JSONDecoder()
            return try? decoder.decode(type, from: data)
        }
        return nil
    }
}
