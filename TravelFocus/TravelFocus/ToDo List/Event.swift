//
//  Event.swift
//  TravelFocus
//
//  Created by Danis Harmandic on 4. 1. 2023..
//

import SwiftUI

struct Event: Identifiable, Hashable, Codable {
    /*#-code-walkthrough(6.codable)*/
    /*#-code-walkthrough(2.eventType)*/
    /*#-code-walkthrough(2.eventProperties)*/
    var id = UUID()
    var symbol: String = EventSymbols.randomName()
    var color: RGBAColor = ColorOptions.random().rgbaColor
    var title = ""
    var tasks = [EventTask(text: "")]
    var date = Date.now
    /*#-code-walkthrough(2.eventProperties)*/

    /*#-code-walkthrough(2.computedProperties)*/
    var period: Period {
        if date < Date.now{
            return .past
            
        } else if date < Date.now.sevenDaysOut {
            return .nextSevenDays
            
        } else if date < Date.now.thirtyDaysOut {
            return .nextThirtyDays
            
        } else {
            return .future
        }
    }
    
    var remainingTaskCount: Int {
        tasks.filter { !$0.isCompleted && !$0.text.isEmpty }.count
    }
    
    var isComplete: Bool {
        tasks.allSatisfy { $0.isCompleted || $0.text.isEmpty }
    }
    /*#-code-walkthrough(2.computedProperties)*/

    static var example = Event(
        symbol: "case.fill",
        title: "Sayulita Trip",
        tasks: [
            EventTask(text: "Buy plane tickets"),
            EventTask(text: "Get a new bathing suit"),
            EventTask(text: "Find an airbnb"),
        ],
        date: Date(timeIntervalSinceNow: 60 * 60 * 24 * 365 * 1.5))
    
    static var delete = Event(symbol: "trash")
}

// Convenience methods for dates.
extension Date {
    var sevenDaysOut: Date {
        Calendar.autoupdatingCurrent.date(byAdding: .day, value: 7, to: self) ?? self
    }
    
    var thirtyDaysOut: Date {
        Calendar.autoupdatingCurrent.date(byAdding: .day, value: 30, to: self) ?? self
    }
}
