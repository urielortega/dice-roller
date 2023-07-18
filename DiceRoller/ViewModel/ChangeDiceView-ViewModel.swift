//
//  ChangeDiceView-ViewModel.swift
//  DiceRoller
//
//  Created by Uriel Ortega on 18/07/23.
//

import Foundation


extension ChangeDiceView {
    @MainActor class ViewModel: ObservableObject {
        @Published var rolls: [Roll]

        let savePath = FileManager.documentsDirectory.appendingPathComponent("SavedRolls")
        
        init() { // For loading data.
            do {
                let data = try Data(contentsOf: savePath)
                rolls = try JSONDecoder().decode([Roll].self, from: data)
            } catch {
                rolls = []
            }
        }
        
        func updateRolls(with roll: Roll) { // Activated when Save button is pressed.
            rolls.append(roll)
            save()
        }

        func save() {
            do {
                let data = try JSONEncoder().encode(rolls)
                try data.write(to: savePath, options: [.atomic, .completeFileProtection])
            } catch {
                print("Unable to save data.")
            }
        }
    }
}