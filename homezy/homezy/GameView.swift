//
//  GameView.swift
//  homezy
//
//  Created by Riccardo Puggioni on 15/10/25.
//

import SwiftUI

struct GameView: View {
    @State private var cleaningProgress: Double = 0.7
    @State private var tidinessProgress: Double = 0.5
    @State private var independenceProgress: Double = 0.3
    
    private var todayToDo: [ToDo] {
        todo.filter { Calendar.current.isDate($0.date, inSameDayAs: Date()) }
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 30) {
                    
                    // MARK: - HEADER
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Earn your independence by keeping your home clean!")
                            .font(.headline)
                            .foregroundColor(.secondary)
                    }
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
                    
                    // MARK: - MOTIVATION SECTION
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
            .navigationTitle("Game")
        }
    }
}

//
// MARK: - RING COMPONENT
//
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

#Preview {
    GameView()
}
