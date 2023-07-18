//
//  Roll.swift
//  DiceRoller
//
//  Created by Uriel Ortega on 18/07/23.
//

import Foundation

struct Roll: Identifiable, Codable {
    struct Dice: Identifiable, Codable {
        var id = UUID()
        var sides: Int
        var result: Int = 1
    }
    
    var id = UUID()
    var date: Date = .now
    
    var dice: [Dice]
    
    var total: Int = 2
    
    static let example = Roll(
        dice: [
            Dice(sides: 6),
            Dice(sides: 6),
            Dice(sides: 6)
        ],
        total: 3
    )
}
