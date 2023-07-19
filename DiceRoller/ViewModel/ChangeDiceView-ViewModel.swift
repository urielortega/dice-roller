//
//  ChangeDiceView-ViewModel.swift
//  DiceRoller
//
//  Created by Uriel Ortega on 18/07/23.
//

import Foundation


extension ChangeDiceView {
    @MainActor class ViewModel: ObservableObject {
        func createRollWith(numberOfDice: Int, numberOfSides: Int) -> Roll {
            var dice: [Roll.Die] = []
            
            for _ in (1...numberOfDice) {
                dice.append(Roll.Die(sides: numberOfSides))
            }
            
            return Roll(dice: dice)
        }
    }
}
