//
//  ToDo.swift
//  homezy
//
//  Created by Riccardo Puggioni on 18/10/25.
//

import Foundation
import SwiftUI

struct ToDo: Identifiable, Hashable {
    let id = UUID()
    let title: String
    let icon: String
    let detail: String
    let date: Date
}

