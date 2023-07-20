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
                        Text("Roll to see your results here!")
                            .foregroundColor(.secondary)
                    }
                } else {
                    List {
                        ForEach(viewModel.rolls) { roll in
                            VStack(alignment: .leading) {
                                Text("Roll created at \(roll.date.formatted(date: .abbreviated, time: .shortened))")
                                Text("Total: \(roll.total)")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                        }
                        .onDelete(perform: removeRows)
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
