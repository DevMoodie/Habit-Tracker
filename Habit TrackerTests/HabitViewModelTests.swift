//
//  HabitViewModelTests.swift
//  Habit TrackerTests
//
//  Created by Moody on 2024-08-26.
//

import XCTest
import CoreData
@testable import Habit_Tracker

final class HabitViewModelTests: XCTestCase {

    var viewModel: HabitViewModel!
    
    private var context: NSManagedObjectContext!

    override func setUp() {
        super.setUp()
        context = PersistenceController.shared.container.viewContext
        viewModel = HabitViewModel()
    }

    override func tearDown() {
        viewModel = nil
        context = nil
        super.tearDown()
    }

    func testAddHabit() {
        viewModel.newHabitName = "Test Habit"
        viewModel.addHabit()
        
        XCTAssertEqual(viewModel.habits.count, 1)
        XCTAssertEqual(viewModel.habits.first?.name, "Test Habit")
        XCTAssertFalse(viewModel.habits.first!.completed)
    }

    func testToggleCompletion() {
        viewModel.newHabitName = "Test Habit"
        viewModel.addHabit()
        
        let habit = viewModel.habits.first!
        viewModel.toggleCompletion(for: habit)
        
        XCTAssertTrue(habit.completed)
        XCTAssertEqual(habit.streak, 1)
        
        viewModel.toggleCompletion(for: habit)
        
        XCTAssertFalse(habit.completed)
        XCTAssertEqual(habit.streak, 0)
    }

    func testDeleteHabit() {
        viewModel.newHabitName = "Test Habit"
        viewModel.addHabit()
        
        viewModel.deleteHabit(at: IndexSet(integer: 0))
        
        XCTAssertEqual(viewModel.habits.count, 0)
    }

}
