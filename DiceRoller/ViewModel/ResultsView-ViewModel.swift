//
//  ResultsView-ViewModel.swift
//  DiceRoller
//
//  Created by Uriel Ortega on 18/07/23.
//

import Foundation

extension ResultsView {
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
        
        func deleteAllRolls() {
            rolls.removeAll()
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
