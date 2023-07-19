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
    }
}
