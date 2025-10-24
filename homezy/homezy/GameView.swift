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
                    .animation(.easeOut(duration: 0.8), value: progress)
                
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
            ZStack {
                Circle()
                    .fill(iconAccentColor.opacity(0.15))
                    .frame(width: 40, height: 40)
                Image(systemName: achievement.iconName)
                    .foregroundColor(iconAccentColor)
            }
            .padding(.trailing, 10)

            VStack(alignment: .leading) {
                Text(achievement.name)
                    .font(.headline)
                Text(achievement.description)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            .frame(maxWidth: .infinity, alignment: .leading)

            Image(systemName: achievement.isUnlocked ? "checkmark.circle.fill" : "lock.fill")
                .foregroundColor(achievement.isUnlocked ? .green : .gray)
                .font(.title2)
        }
        .padding(.vertical, 8)
    }
}

// MARK: - MAIN CHALLENGE VIEW
struct GameView: View {
    @ObservedObject var userVM = UserViewModel.shared
    @ObservedObject var todoVM = ToDoViewModel.shared
    
    @State private var selectedCategory: ToDoCategory = .cleaning
    
    // MARK: - ADDED LOGIC
    @State private var showLevelGlow = false
    @State private var animatedPoints: Int = 0
    
    // Calcolo dinamico del progresso giornaliero per ogni categoria
    private func progress(for category: ToDoCategory) -> Double {
        let allToday = todoVM.todos.filter {
            Calendar.current.isDate($0.date, inSameDayAs: Date()) &&
            $0.category == category
        }
        
        let totalInitial = todo.filter {
            $0.category == category &&
            Calendar.current.isDate($0.date, inSameDayAs: Date())
        }.count
        
        guard totalInitial > 0 else { return 0 }
        let remaining = allToday.count
        let completed = totalInitial - remaining
        
        return max(0, min(Double(completed) / Double(totalInitial), 1))
    }
    
    private var currentLevelProgress: Double {
        let current = Double(userVM.user.currentPoints)
        let next = Double(userVM.user.pointsToNextLevel)
        return next > 0 ? current / next : 0
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 30) {
                    
                    // MARK: - POINTS SECTION (Ora dinamica e animata)
                    VStack(alignment: .leading, spacing: 10) {
                        HStack {
                            Image(systemName: "medal.fill")
                                .foregroundColor(.blue)
                                .font(.title2)
                            
                            // Animazione morbida dei punti
                            Text("Current Points: \(animatedPoints) pts")
                                .font(.title2)
                                .fontWeight(.bold)
                                .transition(.opacity.combined(with: .scale))
                                .animation(.spring(), value: animatedPoints)
                        }
                        
                        // Glow al cambio livello
                        Text("Level \(userVM.user.level): \(userVM.user.currentPoints) / \(userVM.user.pointsToNextLevel) pts")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                            .shadow(color: showLevelGlow ? .green.opacity(0.6) : .clear, radius: 8, x: 0, y: 0)
                            .animation(.easeInOut(duration: 1.0), value: showLevelGlow)
                        
                        ProgressView(value: currentLevelProgress)
                            .progressViewStyle(LinearProgressViewStyle(tint: .green))
                            .scaleEffect(x: 1, y: 2, anchor: .center)
                            .padding(.vertical, 5)
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .padding(.horizontal)
                    .onChange(of: userVM.user.currentPoints) { newValue in
                        withAnimation(.spring()) {
                            animatedPoints = newValue
                        }
                    }
                    .onChange(of: userVM.user.level) { _ in
                        withAnimation(.easeInOut(duration: 0.8)) {
                            showLevelGlow = true
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                            withAnimation(.easeOut(duration: 1.0)) {
                                showLevelGlow = false
                            }
                        }
                    }
                    .onAppear {
                        animatedPoints = userVM.user.currentPoints
                    }
                    
                    // MARK: - RING SECTION (Ora dinamici)
                    HStack(spacing: 30) {
                        RingView(color: .blue, progress: progress(for: .cleaning), label: "Cleaning")
                        RingView(color: .orange, progress: progress(for: .clothing), label: "Clothing")
                        RingView(color: .green, progress: progress(for: .scheduling), label: "Schedule")
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
                        
                        let todayToDo = todoVM.todos.filter {
                            Calendar.current.isDate($0.date, inSameDayAs: Date()) &&
                            $0.category == selectedCategory
                        }
                        
                        ToDoListView(items: todayToDo)
                    }
                    
                    // MARK: - ACHIEVEMENTS SECTION
                    VStack(alignment: .leading, spacing: 0) {
                        Text("Achievements")
                            .font(.title2)
                            .fontWeight(.bold)
                            .padding(.bottom, 10)
                        
                        ForEach(userVM.achievements) { achievement in
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

// MARK: - PREVIEW
#Preview {
    GameView()
}
