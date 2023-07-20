//
//  ContentView.swift
//  DiceRoller
//
//  Created by Uriel Ortega on 18/07/23.
//

import SwiftUI

struct ContentView: View {
    // 1. Create and store a single instance of the ViewRoll class.
    @StateObject var currentRoll = ViewRoll()
    
    @StateObject private var viewModel = ViewModel()
    
    @State private var showingChangeDiceView = false
    @State private var showingResultsView = false

    var body: some View {
        NavigationStack {
            VStack {
                
                Spacer()

                HStack {
                    ForEach(currentRoll.roll.dice) { die in
                        ZStack {
                            RoundedRectangle(cornerRadius: 25)
                                .frame(maxWidth: 180, maxHeight: 180)
                                .foregroundColor(.blue)
                            
                            Text(String(die.result))
                                .font(.system(size: 50, weight: .bold, design: .rounded))
                                .foregroundColor(.white)
                        }
                    }
                }
                .padding()
                
                Spacer()
                
                Button {
                    // Load data to keep it consistent with the rest of the screens.
                    viewModel.updateData()

                    // Change currentRoll with a new Roll (new UUID) to avoid ID duplicates.
                    currentRoll.update(with: Roll(dice: currentRoll.roll.dice))
                    currentRoll.roll.rollAllDice()
                    
                    // Append the new currentRoll.
                    viewModel.updateRolls(with: currentRoll.roll)
                } label: {
                    Text("Roll!")
                        .frame(maxWidth: .infinity, maxHeight: 60)
                        .background(.thickMaterial)
                        .clipShape(Capsule())
                        .shadow(color: Color(.sRGBLinear, white: 0, opacity: 0.30), radius: 10)
                        .padding()
                }
                
                Text("Total: \(currentRoll.roll.total)")
                    .font(.system(size: 30, weight: .medium, design: .none))
                    .padding()
                
                Spacer()
            }
            .navigationTitle("DiceRoller")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        showingResultsView = true
                    } label: {
                        Text("Results")
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showingChangeDiceView = true
                    } label: {
                        Text("Change dice")
                    }
                }
            }
            .sheet(isPresented: $showingResultsView) {
                ResultsView()
            }
            .sheet(isPresented: $showingChangeDiceView) {
                ChangeDiceView()
            }
        }
        .environmentObject(currentRoll) // 2. Post the property into the SwiftUI environment.
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
