//
//  HabitTrackerView.swift
//  Habit Tracker
//
//  Created by Moody on 2024-08-23.
//

import SwiftUI

struct HabitTrackerView: View {
    
    @ObservedObject var viewModel = HabitViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    TextField("New Habit", text: $viewModel.newHabitName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    Button(action: {
                        viewModel.addHabit()
                    }) {
                        Image(systemName: "plus")
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(8)
                    }
                    .disabled(viewModel.newHabitName.isEmpty)
                }
                .padding()
                
                List {
                    ForEach(viewModel.habits) { habit in
                        HStack {
                            Text(habit.name ?? "Unknown Habit")
                            Spacer()
                            Text("Streak: \(habit.streak)")
                            Button(action: {
                                viewModel.toggleCompletion(for: habit)
                            }) {
                                Image(systemName: habit.completed ? "checkmark.circle.fill" : "circle")
                                    .foregroundColor(habit.completed ? .green : .gray)
                            }
                        }
                    }
                    .onDelete(perform: viewModel.deleteHabit)
                }
            }
            .navigationTitle("Habit Tracker")
        }
        .onAppear {
            viewModel.fetchHabits()
        }
    }
}

#Preview {
    HabitTrackerView()
}
