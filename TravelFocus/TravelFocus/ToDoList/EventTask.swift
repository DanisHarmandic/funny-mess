//
//  EventTask.swift
//  TravelFocus
//
//  Created by Danis Harmandic on 4. 1. 2023..
//

import Foundation

struct EventTask: Identifiable, Hashable, Codable {
    var id = UUID()
    var text: String
    var isCompleted = false
    var isNew = false
}
