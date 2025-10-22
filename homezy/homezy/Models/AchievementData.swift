//
//  AchievementData.swift
//  homezy
//
//  Created by Riccardo Puggioni on 22/10/25.
//

import SwiftUI

// MARK: - Core Theme & Data
extension Color {
    // Defines a strong blue matching your app's existing theme
    static let primaryBlue = Color.blue
    static let progressGreen = Color(red: 46/255, green: 204/255, blue: 113/255) // #2ECC71
    static let achievementLocked = Color(.systemGray4)
}

// MARK: - Game Data Structures
struct UserData {
    var currentPoints: Int
    var level: Int
    var pointsToNextLevel: Int
    var profileImageName: String
}

struct GameCategory {
    var name: String
    var iconName: String
    var color: Color
}

struct Achievement: Identifiable {
    let id = UUID()
    var name: String
    var description: String
    var iconName: String
    var isUnlocked: Bool
    var categoryName: String // Links to a GameCategory
}

// MARK: - Initial Game State (User has not played yet)
let initialUserData = UserData(
    currentPoints: 0,
    level: 1,
    pointsToNextLevel: 250, // User needs 250 points for Level 2
    profileImageName: "person.circle.fill"
)

let gameCategories: [GameCategory] = [
    .init(name: "Cleaning", iconName: "shower.fill", color: Color(red: 231/255, green: 76/255, blue: 60/255)), // Reddish-Orange
    .init(name: "Clothing", iconName: "tshirt.fill", color: Color(red: 155/255, green: 89/255, blue: 182/255)), // Purple
    .init(name: "Scheduling", iconName: "calendar.badge.clock.fill", color: .primaryBlue), // Blue
]

let initialAchievements: [Achievement] = [
    // All achievements are LOCKED (isUnlocked: false)
    .init(name: "100 Points!", description: "Earn 100 total points.", iconName: "star.fill", isUnlocked: false, categoryName: "Scheduling"),
    .init(name: "Centurion", description: "Complete 10 total tasks.", iconName: "trophy.fill", isUnlocked: false, categoryName: "Scheduling"),
    .init(name: "High Scorer", description: "Reach 500 total points.", iconName: "crown.fill", isUnlocked: false, categoryName: "Scheduling"),
    
    .init(name: "3-Day Streak", description: "Complete a task 3 days in a row.", iconName: "flame.fill", isUnlocked: false, categoryName: "Scheduling"),
    .init(name: "Top Bedroom", description: "Complete 10 bedroom tasks.", iconName: "bed.double.fill", isUnlocked: false, categoryName: "Cleaning"),
    .init(name: "Tidy Kitchen", description: "Complete 5 kitchen tasks.", iconName: "fork.knife", isUnlocked: false, categoryName: "Cleaning"),
    .init(name: "Closet Crusher", description: "Complete 5 clothes tasks.", iconName: "hanger", isUnlocked: false, categoryName: "Clothing"),
]
