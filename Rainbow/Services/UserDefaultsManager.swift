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
        guard let encoded = try? encoder.encode(object) else { return }
        defaults.set(encoded, forKey: key.rawValue)
    }
    
    // MARK: - Load Methods
    func load<T>(type: T.Type, for key: Key) -> T? {
        defaults.object(forKey: key.rawValue) as? T
    }
    
    func loadObject<T: Decodable>(type: T.Type, for key: Key) -> T? {
        guard let data = defaults.data(forKey: key.rawValue) else { return nil}
        let deconder = JSONDecoder()
        return try? deconder.decode(type, from: data)
    }
}


