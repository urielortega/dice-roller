//
//  Roll.swift
//  DiceRoller
//
//  Created by Uriel Ortega on 18/07/23.
//

import Foundation

struct Roll: Identifiable, Codable {
    struct Die: Identifiable, Codable {
        var id = UUID()
        var sides: Int
        var result: Int = 1
        
        mutating func rollIt() {
            result = Int.random(in: 1...sides)
        }
    }
    
    var id = UUID()
    var date: Date = .now
    
    var dice: [Die]
    
    var total: Int {
        dice.reduce(0) { $0 + $1.result } // Make a sum of each die result, starting with 0.
    }
    
    mutating func rollAllDice() {
        for index in dice.indices {
            dice[index].rollIt()
            print(dice[index].result)
        }
    }
    
    static let example = Roll(
        dice: [
            Die(sides: 6),
            Die(sides: 6),
            Die(sides: 6)
        ]
    )
}
