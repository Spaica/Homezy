//
//  AchievementData.swift
//  homezy
//
//  Created by Riccardo Puggioni on 22/10/25.
//

import SwiftUI
import Combine

// MARK: - Game Data Structures
struct UserData: Codable {
    var currentPoints: Int
    var level: Int
    var pointsToNextLevel: Int
    var profileImageName: String
}

struct Achievement: Identifiable, Codable {
    var id: UUID = UUID()
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
    pointsToNextLevel: 250,
    profileImageName: "person.circle.fill"
)

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

// MARK: - ADDED LOGIC
// Gestione persistente del profilo utente, punti e achievements
class UserViewModel: ObservableObject {
    static let shared = UserViewModel()
    
    @Published var user: UserData
    @Published var achievements: [Achievement]
    
    private let userKey = "savedUserData"
    private let achievementsKey = "savedAchievements"
    
    init() {
        if let data = UserDefaults.standard.data(forKey: userKey),
           let decoded = try? JSONDecoder().decode(UserData.self, from: data) {
            self.user = decoded
        } else {
            self.user = initialUserData
        }
        
        if let data = UserDefaults.standard.data(forKey: achievementsKey),
           let decoded = try? JSONDecoder().decode([Achievement].self, from: data) {
            self.achievements = decoded
        } else {
            self.achievements = initialAchievements
        }
    }
    
    // Aggiunge punti e controlla il livello
    func addPoints(_ amount: Int) {
        user.currentPoints += amount
        
        if user.currentPoints >= user.pointsToNextLevel {
            user.level += 1
            user.currentPoints = 0
            user.pointsToNextLevel += 250
        }
        
        checkAchievements()
        saveData()
    }
    
    // Sblocca gli achievements al raggiungimento di certe soglie
    private func checkAchievements() {
        for i in 0..<achievements.count {
            switch achievements[i].name {
            case "100 Points!" where user.currentPoints >= 100:
                achievements[i].isUnlocked = true
            case "High Scorer" where user.level >= 3:
                achievements[i].isUnlocked = true
            case "Centurion" where user.level >= 2:
                achievements[i].isUnlocked = true
            default:
                break
            }
        }
        saveData()
    }
    
    // Salva i dati su UserDefaults
    private func saveData() {
        if let encodedUser = try? JSONEncoder().encode(user) {
            UserDefaults.standard.set(encodedUser, forKey: userKey)
        }
        if let encodedAch = try? JSONEncoder().encode(achievements) {
            UserDefaults.standard.set(encodedAch, forKey: achievementsKey)
        }
    }
}
