//
//  ContainerView.swift
//  homezy
//
//  Created by Riccardo Puggioni on 15/10/25.
//

import SwiftUI

struct ContainerView: View {
    
    var body: some View {
            TabView {
                Tab("Home", systemImage: "house.fill"){
                    HomePageView()
                }
                Tab("Game", systemImage: "gamecontroller.fill"){
                    GameView()
                }
                /*Tab("Calendar", systemImage: "calendar"){
                    CalendarView()
                }*/
                Tab("Tips", systemImage: "magnifyingglass"){
                    SearchTipsView()
                }
        }
    }
}


#Preview {
    ContainerView()
}
