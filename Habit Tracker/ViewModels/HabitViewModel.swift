//
//  HabitViewModel.swift
//  Habit Tracker
//
//  Created by Moody on 2024-08-23.
//

import Foundation
import CoreData
import Combine

class HabitViewModel: ObservableObject {
    @Published var habits: [Habit] = []
    @Published var newHabitName: String = ""
    
    private var cancellables = Set<AnyCancellable>()
    private let context = PersistenceController.shared.container.viewContext
    
    func fetchHabits() {
        let request: NSFetchRequest<Habit> = Habit.fetchRequest()
        do {
            habits = try context.fetch(request)
        } catch {
            print("Failed to fetch habits: \(error.localizedDescription)")
        }
    }
    
    func addHabit() {
        let newHabit = Habit(context: context)
        newHabit.name = newHabitName
        newHabit.completed = false
        newHabit.streak = 0
        
        saveContext()
        fetchHabits()
        newHabitName = ""
    }
    
    func toggleCompletion(for habit: Habit) {
        habit.completed.toggle()
        if habit.completed {
            habit.streak += 1
        } else {
            habit.streak = 0
        }
        saveContext()
        fetchHabits()
    }
    
    func deleteHabit(at offsets: IndexSet) {
        for index in offsets {
            let habit = habits[index]
            context.delete(habit)
        }
        saveContext()
        fetchHabits()
    }
    
    private func saveContext() {
        do {
            try context.save()
        } catch {
            print("Failed to save context: \(error.localizedDescription)")
        }
    }
}
