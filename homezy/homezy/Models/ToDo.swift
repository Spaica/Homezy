//
//  ToDo.swift
//  homezy
//
//  Created by Riccardo Puggioni on 18/10/25.
//

import Foundation
import SwiftUI

enum ToDoCategory: String, CaseIterable, Identifiable, Codable {
    case cleaning = "Cleaning"
    case clothing = "Clothing"
    case scheduling = "Scheduling"
    
    var id: String { self.rawValue }
}

struct ToDo: Identifiable, Hashable, Codable {
    var id: UUID = UUID()
    let title: String
    let icon: String
    let detail: String
    let date: Date
    let category: ToDoCategory
}
