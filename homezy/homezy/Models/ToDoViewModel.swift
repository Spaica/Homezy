//
//  ToDoViewModel.swift
//  homezy
//
//  Created by Riccardo Puggioni on 18/10/25.
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
        date: date(byAddingDays: 0),
        category: .clothing
    ),
    .init(
        title: "Wash dishes",
        icon: "dishwasher.fill",
        detail: "Don't leave them for tomorrow! Wash all the dishes and cookware.",
        date: date(byAddingDays: 0),
        category: .cleaning
    ),
    .init(
        title: "Clean bathroom",
        icon: "shower.fill",
        detail: "A clean bathroom is a happy bathroom.",
        date: date(byAddingDays: 1),
        category: .cleaning
    ),
    .init(
        title: "Clean the office",
        icon: "lamp.desk.fill",
        detail: "Organize your documents, wipe your desk, and clear out clutter.",
        date: date(byAddingDays: 2),
        category: .cleaning
    ),
    .init(
        title: "Change the blankets",
        icon: "bed.double.fill",
        detail: "Fresh sheets feel amazing! Remove the old blankets and put on a fresh set.",
        date: date(byAddingDays: 3),
        category: .cleaning
    ),
    .init(
        title: "Review Digital Files",
        icon: "laptopcomputer",
        detail: "Tidy your computer desktop, organize the downloads folder, and check backups.",
        date: date(byAddingDays: 0),
        category: .scheduling
    ),
    .init(
        title: "Skill Practice (30 Min)",
        icon: "brain.head.profile",
        detail: "Dedicate 30 minutes to practicing a new language, instrument, or professional skill.",
        date: date(byAddingDays: 0),
        category: .scheduling
    ),
    .init(
        title: "Sanitize Surfaces",
        icon: "hand.tap",
        detail: "Disinfect all high-touch areas: door knobs, light switches, and remote controls.",
        date: date(byAddingDays: 1),
        category: .cleaning
    ),
    .init(
        title: "Wipe Kitchen Cabinets",
        icon: "kitchen.fill",
        detail: "Wipe down cabinet doors, especially near the stove and handles.",
        date: date(byAddingDays: 3),
        category: .cleaning
    ),
    .init(
        title: "Clean Footwear",
        icon: "shoeprints.fill",
        detail: "Wipe down and polish/clean all shoes used during the week.",
        date: date(byAddingDays: 3),
        category: .clothing
    ),
    .init(
        title: "Confirm Commitments",
        icon: "calendar.badge.checkmark",
        detail: "Send confirmations or reminders for any appointments scheduled for the upcoming week.",
        date: date(byAddingDays: 3),
        category: .scheduling
    ),
    .init(
        title: "Tidy Entryway",
        icon: "lock.fill",
        detail: "Organize shoes, hang up coats, and sort mail in the entrance area.",
        date: date(byAddingDays: 5),
        category: .cleaning
    ),

    .init(
        title: "Deep Fold Drawers (KonMari)",
        icon: "square.grid.2x2.fill",
        detail: "Use a folding method to maximize space and organization in one dresser drawer.",
        date: date(byAddingDays: 6),
        category: .clothing
    )
]
