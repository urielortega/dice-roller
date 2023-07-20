//
//  ResultsView.swift
//  DiceRoller
//
//  Created by Uriel Ortega on 18/07/23.
//

import SwiftUI

struct ResultsView: View {
    @StateObject private var viewModel = ViewModel()
    @Environment(\.dismiss) var dismiss
    @Environment(\.accessibilityVoiceOverEnabled) var voiceOverEnabled

    var body: some View {
        NavigationStack {
            Group {
                if (viewModel.rolls.isEmpty) {
                    VStack {
                        Image(systemName: "die.face.3.fill")
                            .padding()
                            .foregroundColor(.secondary)
                            .accessibilityHidden(true)
                        Text("Roll to see your results here!")
                            .foregroundColor(.secondary)
                    }
                    .accessibilityElement()
                    .accessibilityLabel("Roll to see your results here!")
                } else {
                    List {
                        ForEach(viewModel.rolls) { roll in
                            VStack(alignment: .leading) {
                                Text("Roll created at \(roll.date.formatted(date: .abbreviated, time: .shortened))")
                                Text("Result: \(roll.total)")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                            .accessibilityElement()
                            .accessibilityLabel("\(roll.date.formatted(date: .omitted, time: .shortened)), \(roll.date.formatted(date: .abbreviated, time: .omitted))")
                            .accessibilityHint("Result was \(roll.total)")
                        }
                        .onDelete(perform: removeRows)
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    if voiceOverEnabled {
                        Button {
                            viewModel.deleteAllRolls()
                        } label: {
                            Text("Delete all rolls")
                        }
                    } else if (!viewModel.rolls.isEmpty) {
                        EditButton()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        dismiss()
                    } label: {
                        Text("OK")
                    }
                }
            }
        }
    }
    
    func removeRows(at offsets: IndexSet) {
        viewModel.rolls.remove(atOffsets: offsets)
        viewModel.save()
    }
}

struct ResultsView_Previews: PreviewProvider {
    static var previews: some View {
        ResultsView()
    }
}
