//
//  ChallengeView.swift
//  homezy
//
//  Created by Riccardo Puggioni on 18/10/25.
//

import SwiftUI

struct ChallengeView: View {
    let todoItem: ToDo
    
    // MARK: - ADDED LOGIC
    @Environment(\.dismiss) private var dismiss
    @State private var popToHome: Bool = false

    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 20) {
                
                // MARK: - HEADER
                HStack {
                    Image(systemName: todoItem.icon)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                        .foregroundColor(.blue)
                    Text(todoItem.title)
                        .font(.largeTitle)
                        .bold()
                }
                
                Divider()
                
                // MARK: - DETAILS
                Text("Detail: \(todoItem.title)")
                    .font(.title2)
                    .bold()
                
                Text("\(todoItem.detail)")
                    .font(.body)
                    .foregroundColor(.secondary)
                
                Spacer()
                
                // MARK: - NAVIGATION TO AI VIEW
                NavigationLink("Start challenge") {
                    AIView(todoItem: todoItem, popToHome: $popToHome)
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.green)
                .foregroundColor(.white)
                .clipShape(Capsule())
            }
            .padding()
            .navigationTitle(todoItem.title)
            .navigationBarTitleDisplayMode(.inline)
            // MARK: - ADDED LOGIC
            // When AIView sets popToHome = true, dismiss this screen to return to HomePage
            .onChange(of: popToHome) { newValue in
                if newValue {
                    dismiss()
                }
            }
        }
    }
}

// MARK: - PREVIEW
#Preview {
    ChallengeView(
        todoItem: ToDo(
            title: "Wash the dishes",
            icon: "fork.knife.circle.fill",
            detail: "Use the AI camera to verify the clean plates.",
            date: Date(),
            category: .cleaning
        )
    )
}
