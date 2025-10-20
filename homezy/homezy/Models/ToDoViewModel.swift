//
//  ToDoViewModel.swift
//  homezy
//
//  Created by Riccardo Puggioni on 18/10/25.
//

import Foundation
import SwiftUI

private func date(byAddingDays days: Int) -> Date {
    Calendar.current.date(byAdding: .day, value: days, to: Date())!
}

let todo: [ToDo] = [
    .init(
        title: "Fold Clothes",
        icon: "tshirt.fill",
        detail: "Time to tidy up! Please fold and put away all the clean clothes in your wardrobe.",
        date: date(byAddingDays: 0)
    ),
    .init(
        title: "Wash dishes",
        icon: "dishwasher.fill",
        detail: "Don't leave them for tomorrow! Wash all the dishes and cookware.",
        date: date(byAddingDays: 0)
    ),
    .init(
        title: "Clean bathroom",
        icon: "shower.fill",
        detail: "A clean bathroom is a happy bathroom.",
        date: date(byAddingDays: 1)
    ),
    .init(
        title: "Clean the office",
        icon: "lamp.desk.fill",
        detail: "Organize your documents, wipe your desk, and clear out clutter.",
        date: date(byAddingDays: 2)
    ),
    .init(
        title: "Change the blankets",
        icon: "bed.double.fill",
        detail: "Fresh sheets feel amazing! Remove the old blankets and put on a fresh set.",
        date: date(byAddingDays: 3)
    )
]
