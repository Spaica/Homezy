//
//  GameView.swift
//  homezy
//
//  Created by Riccardo Puggioni on 15/10/25.
//

import SwiftUI

// MARK: - RING COMPONENT
struct RingView: View {
    var color: Color
    var progress: Double
    var label: String
    
    var body: some View {
        VStack {
            ZStack {
                Circle()
                    .stroke(Color.gray.opacity(0.2), lineWidth: 15)
                Circle()
                    .trim(from: 0, to: progress)
                    .stroke(color, style: StrokeStyle(lineWidth: 15, lineCap: .round))
                    .rotationEffect(.degrees(-90))
                    .animation(.easeOut(duration: 1.0), value: progress)
                
                Text("\(Int(progress * 100))%")
                    .font(.headline)
            }
            .frame(width: 100, height: 100)
            
            Text(label)
                .font(.subheadline)
        }
    }
}

// MARK: - ACHIEVEMENT ROW COMPONENT
struct AchievementRowView: View {
    let achievement: Achievement
    
    // Fallback color since categories are not defined anymore
    private var iconAccentColor: Color {
        switch achievement.categoryName {
        case "Cleaning": return .blue
        case "Scheduling": return .green
        case "Clothing": return .orange
        default: return .gray
        }
    }

    var body: some View {
        HStack {
            // Icon Container
            ZStack {
                Circle()
                    .fill(iconAccentColor.opacity(0.15))
                    .frame(width: 40, height: 40)
                Image(systemName: achievement.iconName)
                    .foregroundColor(iconAccentColor)
            }
            .padding(.trailing, 10)

            // Details
            VStack(alignment: .leading) {
                Text(achievement.name)
                    .font(.headline)
                Text(achievement.description)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            .frame(maxWidth: .infinity, alignment: .leading)

            // Status Icon (Checkmark or Lock)
            Image(systemName: achievement.isUnlocked ? "checkmark.circle.fill" : "lock.fill")
                .foregroundColor(achievement.isUnlocked ? .green : .gray)
                .font(.title2)
        }
        .padding(.vertical, 8)
    }
}

// MARK: - MAIN CHALLENGE VIEW
struct GameView: View {
    @State private var cleaningProgress: Double = 0.7
    @State private var tidinessProgress: Double = 0.5
    @State private var independenceProgress: Double = 0.3
    
    @State private var user = initialUserData
    @State private var achievements = initialAchievements
    @State private var selectedCategory: ToDoCategory = .cleaning
    
    // fiklter toDo by day aand category
    private var todayToDo: [ToDo] {
        todo.filter { item in
            Calendar.current.isDate(item.date, inSameDayAs: Date()) &&
            item.category == selectedCategory
        }
    }
    
    private var currentLevelProgress: Double {
        let current = Double(user.currentPoints)
        let next = Double(user.pointsToNextLevel)
        return next > 0 ? current / next : 0
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 30) {
                    
                    // MARK: - POINTS SECTION
                    VStack(alignment: .leading, spacing: 10) {
                        HStack {
                            Image(systemName: "medal.fill")
                                .foregroundColor(.blue)
                                .font(.title2)
                            Text("Current Points: \(user.currentPoints) pts")
                                .font(.title2)
                                .fontWeight(.bold)
                        }
                        
                        Text("Level \(user.level): \(user.currentPoints) / \(user.pointsToNextLevel) pts")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        
                        ProgressView(value: currentLevelProgress)
                            .progressViewStyle(LinearProgressViewStyle(tint: .green))
                            .scaleEffect(x: 1, y: 2, anchor: .center)
                            .padding(.vertical, 5)
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .padding(.horizontal)
                    
                    // MARK: - RING SECTION
                    HStack(spacing: 30) {
                        RingView(color: .blue, progress: cleaningProgress, label: "Cleaning")
                        RingView(color: .green, progress: tidinessProgress, label: "Tidiness")
                        RingView(color: .orange, progress: independenceProgress, label: "Independence")
                    }
                    .padding(.horizontal)
                    
                    // MARK: - TODAY'S TASKS
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Today's Tasks")
                            .font(.title2.bold())
                            .padding(.horizontal)
                        
                        Picker("Category", selection: $selectedCategory) {
                            ForEach(ToDoCategory.allCases) { category in
                                Text(category.rawValue).tag(category)
                            }
                        }
                        .pickerStyle(.segmented)
                        .padding(.horizontal)
                        
                        ToDoListView(items: todayToDo)
                    }
                    
                    // MARK: - ACHIEVEMENTS SECTION
                    VStack(alignment: .leading, spacing: 0) {
                        Text("Achievements")
                            .font(.title2)
                            .fontWeight(.bold)
                            .padding(.bottom, 10)
                        
                        ForEach(achievements) { achievement in
                            AchievementRowView(achievement: achievement)
                        }
                    }
                    .padding(.horizontal)
                }
                .padding(.bottom, 40)
            }
            .navigationTitle("Challenge")
        }
    }
}

#Preview {
    GameView()
}
