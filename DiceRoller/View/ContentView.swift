//
//  ContentView.swift
//  DiceRoller
//
//  Created by Uriel Ortega on 18/07/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = ViewModel()
    @State private var lastRoll: Roll = Roll.example
    
    @State private var showingChangeDiceView = false
    @State private var showingResultsView = false

    var body: some View {
        NavigationStack {
            VStack {
                
                Spacer()

                HStack {
                    ForEach(lastRoll.dice) { die in
                        ZStack {
                            RoundedRectangle(cornerRadius: 25)
                                .frame(maxHeight: 180)
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
                    lastRoll.rollAllDice()
                } label: {
                    Text("Roll!")
                        .frame(maxWidth: .infinity, maxHeight: 60)
                        .background(.thickMaterial)
                        .clipShape(Capsule())
                        .shadow(color: Color(.sRGBLinear, white: 0, opacity: 0.30), radius: 10)
                        .padding()
                }
                
                Text("Total: \(lastRoll.total)")
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
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
