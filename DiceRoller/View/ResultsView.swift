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

    var body: some View {
        NavigationStack {
            Group {
                if (viewModel.rolls.isEmpty) {
                    VStack {
                        Image(systemName: "die.face.3.fill")
                            .padding()
                            .foregroundColor(.secondary)
                        Text("You haven't rolled any dice yet")
                            .foregroundColor(.secondary)
                    }
                } else {
                    List(viewModel.rolls) { roll in
                        VStack(alignment: .leading) {
                            Text("Roll created at \(roll.date.formatted(date: .abbreviated, time: .shortened))")
                            Text("Total: \(roll.total)")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                    }
                }
            }
            .toolbar {
                Button {
                    dismiss()
                } label: {
                    Text("OK")
                }
            }
        }
    }
}

struct ResultsView_Previews: PreviewProvider {
    static var previews: some View {
        ResultsView()
    }
}
