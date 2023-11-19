//
//  Settings.swift
//  Rainbow
//
//  Created by Kirill Taraturin on 16.11.2023.
//

import Foundation

struct Settings: Codable {
    var gameTime: Int
    var gameTimeValueSlider: Float
    var speedTimeValueSlider: Float
    var speed: Int
    var isSubstrate: Bool
    var isBackgroundNeed: Bool
    var backgroundColor: [CGFloat]
    var buttonColors: [[CGFloat]]
    var fontSize: CGFloat
//    var wordsPosition: Int
}
