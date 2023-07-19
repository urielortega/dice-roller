//
//  ChangeDiceView.swift
//  DiceRoller
//
//  Created by Uriel Ortega on 18/07/23.
//

import SwiftUI

struct ChangeDiceView: View {
    @StateObject private var viewModel = ViewModel()
    
    // 3. Read the object back out of the environment.
    @EnvironmentObject var currentRoll: ViewRoll
    @Environment(\.dismiss) var dismiss
    
    @State private var numberOfDice = 2
    @State private var numberOfSides = 6
    
    let sides = [4, 6, 8, 10, 12, 20, 100]

    var body: some View {
        NavigationStack {
            Form {
                Section {
                    Stepper("Number of dice: \(numberOfDice)", value: $numberOfDice, in: 1...3)
                }
                
                Section("How many sides for each die?") {
                    // Stepper("Number of sides: \(numberOfSides)", value: $numberOfSides, in: 1...100)
                    Picker("Number of sides", selection: $numberOfSides) {
                        ForEach(sides, id: \.self) {
                            Text($0, format: .number)
                        }
                    }
                    .pickerStyle(.segmented)
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Text("Cancel")
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        currentRoll.update(
                            with: viewModel.createRollWith(
                                numberOfDice: numberOfDice,
                                numberOfSides: numberOfSides
                            )
                        )

                        dismiss()
                    } label: {
                        Text("Save")
                    }
                }
            }
        }
        .onAppear {
            numberOfDice = currentRoll.roll.dice.count
            numberOfSides = currentRoll.roll.dice.first!.sides
        }
    }
}

struct ChangeDiceView_Previews: PreviewProvider {
    static var previews: some View {
        ChangeDiceView()
    }
}
