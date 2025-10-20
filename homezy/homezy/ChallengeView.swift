//
//  ChallengeView.swift
//  homezy
//
//  Created by Riccardo Puggioni on 18/10/25.
//

import SwiftUI

struct ChallengeView: View {
    let todoItem: ToDo

    var body: some View {
        NavigationStack{
            VStack(alignment: .leading, spacing: 20) {
                
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
                
                Text("Detail: \(todoItem.title)")
                    .font(.title2)
                    .bold()
                
                Text("\(todoItem.detail)")
                    .font(.body)
                    .foregroundColor(.secondary)
                
                Spacer()
                
                NavigationLink("Completa challenge"){
                    AIView()
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
        }
    }
}

/*#Preview {
    ChallengeView(todoItem: ToDo(title: "Fold clothes", icon: "tshirt.fill", detail: "ldofkvnosveovoVAVOIAN", date: date(byAddingDays: 0)))
}
*/
