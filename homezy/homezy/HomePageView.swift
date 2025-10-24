//
//  HomePageView.swift
//  homezy
//
//  Created by Riccardo Puggioni on 15/10/25.
//

import SwiftUI

struct HomePageView: View {
    // MARK: - ADDED LOGIC
    // Ora osserva il ViewModel per aggiornare automaticamente la lista dei ToDo
    @ObservedObject var todoVM = ToDoViewModel.shared
    
    @State private var currentDate = Date()
    @State private var selectedDate: Date? = Date()
    
    // MARK: - ADDED LOGIC
    private var nextDays: [Date] {
        (1...7).compactMap { Calendar.current.date(byAdding: .day, value: $0, to: Date()) }
    }
    
    // MARK: - Filtraggio ToDo
    private var todayToDo: [ToDo] {
        todoVM.todos.filter { Calendar.current.isDate($0.date, inSameDayAs: Date()) }
    }
    
    private var selectedDayToDo: [ToDo] {
        guard let selected = selectedDate else { return [] }
        return todoVM.todos.filter { Calendar.current.isDate($0.date, inSameDayAs: selected) }
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 25) {
                    
                    // MARK: - TO DO'S SECTION
                    Text("To do's")
                        .font(.title2)
                        .bold()
                        .padding(.horizontal)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    // Lista dinamica che si aggiorna al completamento dei ToDo
                    ToDoListView(items: todayToDo)
                    
                    // MARK: - WHAT'S NEXT
                    Text("What's Next")
                        .font(.title2)
                        .bold()
                        .padding(.horizontal)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    // Calendario con i prossimi 5 giorni
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 15) {
                            ForEach(nextDays, id: \.self) { date in
                                DayCalendarCell(date: date, selectedDate: $selectedDate)
                                    .onTapGesture {
                                        withAnimation {
                                            selectedDate = date
                                        }
                                    }
                            }
                        }
                        .padding(.horizontal)
                        .padding(.vertical, 5)
                    }
                    
                    // MARK: - TO DO'S OF THE DAY
                    if let selected = selectedDate {
                        VStack(alignment: .leading, spacing: 8) {
                            Text(selected, format: .dateTime.day().month(.wide))
                                .font(.headline)
                                .foregroundColor(.secondary)
                                .padding(.horizontal)
                            
                            ToDoListView(items: selectedDayToDo)
                        }
                    }
                }
                .padding(.bottom, 40)
            }
            .navigationTitle("Homepage")
        }
    }
}

//
// MARK: - COMPONENTE LISTA TO-DO
//
struct ToDoListView: View {
    let items: [ToDo]
    
    var body: some View {
        if items.isEmpty {
            Text("Nothing to do for this day 🎉")
                .foregroundColor(.secondary)
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.vertical, 20)
        } else {
            VStack(spacing: 0) {
                List {
                    ForEach(items, id: \.id) { item in
                        NavigationLink(destination: ChallengeView(todoItem: item)) {
                            HStack(spacing: 15) {
                                Image(systemName: item.icon)
                                    .foregroundColor(.blue)
                                    .font(.title2)
                                    .frame(width: 30)
                                
                                Text(item.title)
                                    .foregroundColor(.primary)
                                    .font(.body)
                            }
                            .padding(.vertical, 8)
                        }
                        .listRowBackground(Color(.systemGray6))
                        .listRowInsets(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
                    }
                }
                .scrollContentBackground(.hidden)
                .listStyle(.plain)
                .frame(height: CGFloat(items.count) * 55)
            }
            .background(Color(.systemGray5))
            .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
            .padding(.horizontal)
            .shadow(color: .black.opacity(0.05), radius: 4, x: 0, y: 2)
        }
    }
}

//
// MARK: - DAY ON CALENDAR
//
struct DayCalendarCell: View {
    let date: Date
    @Binding var selectedDate: Date?
    
    var isSelected: Bool {
        Calendar.current.isDate(date, equalTo: selectedDate ?? Date(), toGranularity: .day)
    }
    
    var body: some View {
        VStack {
            Text(date, format: .dateTime.weekday(.abbreviated))
                .font(.caption)
                .bold()
            Text(date, format: .dateTime.day())
                .font(.title3)
                .bold()
        }
        .frame(width: 50, height: 70)
        .background(isSelected ? Color.blue : Color.gray.opacity(0.15))
        .foregroundColor(isSelected ? .white : .primary)
        .cornerRadius(10)
        .scaleEffect(isSelected ? 1.05 : 1.0)
        .animation(.spring(), value: isSelected)
    }
}

// MARK: - PREVIEW
#Preview {
    HomePageView()
}
