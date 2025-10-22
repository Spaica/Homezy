//
//  ChallengeView.swift
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
    
    // Helper to find the correct color for the icon based on category
    private var iconAccentColor: Color {
        gameCategories.first(where: { $0.name == achievement.categoryName })?.color ?? .gray
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
                    .foregroundColor(.black)
                Text(achievement.description)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            .frame(maxWidth: .infinity, alignment: .leading)

            // Status Icon (Checkmark or Lock)
            Image(systemName: achievement.isUnlocked ? "checkmark.circle.fill" : "lock.fill")
                .foregroundColor(achievement.isUnlocked ? .progressGreen : .achievementLocked)
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

    private var todayToDo: [ToDo] {
        todo.filter { Calendar.current.isDate($0.date, inSameDayAs: Date()) }
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
                                .foregroundColor(.primaryBlue)
                                .font(.title2)
                            Text("Current Points: \(user.currentPoints) pts")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(.black)
                        }
                        
                        Text("Level \(user.level): \(user.currentPoints) / \(user.pointsToNextLevel) pts")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        
                        ProgressView(value: currentLevelProgress)
                            .progressViewStyle(LinearProgressViewStyle(tint: .progressGreen))
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
                    Text("Today's Tasks")
                        .font(.title2.bold())
                        .padding(.horizontal)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    ToDoListView(items: todayToDo)
                    
                    // MARK: - ACHIEVEMENTS SECTION
                    VStack(alignment: .leading, spacing: 0) {
                        Text("Achievements")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                            .padding(.bottom, 10)
                        
                        ForEach(achievements) { achievement in
                            AchievementRowView(achievement: achievement)
                        }
                    }
                    .padding(.horizontal)
                    
                    // MARK: - MOTIVATION
                    VStack(alignment: .center, spacing: 10) {
                        Text("💪 Keep it up!")
                            .font(.title2.bold())
                        Text("Every task you complete brings you closer to independence.")
                            .multilineTextAlignment(.center)
                            .foregroundColor(.secondary)
                    }
                    .padding(.horizontal)
                    .padding(.top, 20)
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
