//
//  Challenge.swift
//  homezy
//
//  Created by Riccardo Puggioni on 18/10/25.
//
//sevre veramente bho per ora l'ho fatta?
import Foundation
import SwiftUI

struct Challenge: Identifiable, Hashable {
    let id = UUID()
    let title: String
    let icon: String
    let details: String
}
