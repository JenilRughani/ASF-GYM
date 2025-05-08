//
//  CalenderViewModel.swift
//  ASF
//
//  Created by Jenil Rughani on 01/04/25.
//

import Foundation

class CalenderViewModel: ObservableObject {
    @Published var events: [Event] = []

    init() {
        loadSampleEvents() // Load events on initialization
    }

    func loadSampleEvents() {
        let calendar = Calendar.current
        events = [
            Event(title: "Meeting", description: "Project discussion", date: calendar.date(from: DateComponents(year: 2024, month: 4, day: 2, hour: 10, minute: 30))!),
            Event(title: "Workout", description: "Gym session", date: calendar.date(from: DateComponents(year: 2024, month: 4, day: 3, hour: 7, minute: 0))!),
            Event(title: "Lunch", description: "Lunch with friend", date: calendar.date(from: DateComponents(year: 2024, month: 4, day: 2, hour: 13, minute: 0))!),
            Event(title: "Coding", description: "iOS Development", date: calendar.date(from: DateComponents(year: 2024, month: 4, day: 3, hour: 16, minute: 30))!)
        ]
    }

    func events(for date: Date) -> [Event] {
        let calendar = Calendar.current
        return events.filter { calendar.isDate($0.date, inSameDayAs: date) }
                     .sorted { $0.date < $1.date } // Sort by time
    }
}
