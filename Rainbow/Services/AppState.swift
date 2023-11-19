//
//  AppState.swift
//  Rainbow
//
//  Created by Kirill Taraturin on 16.11.2023.
//

import UIKit

final class AppState {
    let defaults = UserDefaultsManager()
    let defaultSettings: Settings
    let buttonColors: [UIColor] = [ .greenGameColor, .darkGreenGameColor, .pinkGameColor, .lightBlueGameColor, .darkRedGameColor, .purpleGameColor, .blueGameColor, .orangeGameColor, .redGameColor, .yellowGameColor, .blackGameColor, .grayGameColor]
    var games = [ResultsCardModel]()
    
    init() {
        let buttonColor = buttonColors.compactMap { $0.cgColor.components }
        let backgroundColor = UIColor.grayBackgroundColor.cgColor.components!
        print(buttonColor)
//        defaults.deleteObject(for: .settings)
        self.defaultSettings = Settings(gameTime: 120, gameTimeValueSlider: 2, speedTimeValueSlider: 5, speed: 5, isSubstrate: true, isBackgroundNeed: true, backgroundColor: backgroundColor, buttonColors: buttonColor)
    }
}
