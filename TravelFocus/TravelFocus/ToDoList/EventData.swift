//
//  EventData.swift
//  TravelFocus
//
//  Created by Danis Harmandic on 4. 1. 2023..
//

import SwiftUI

class EventData: ObservableObject {
    @Published var events: [Event] = [
        Event(symbol: "gift.fill",
              color: Color.red.rgbaColor,
              title: "Anin rođendan",
              tasks: [EventTask(text: "Torta"),
                      EventTask(text: "Papirni tanjiri"),
                      EventTask(text: "Čaše"),
                      EventTask(text: "Baloni"),
                     ],
              date: Date.roundedHoursFromNow(60 * 60 * 24 * 30)),
        Event(symbol: "theatermasks.fill",
              color: Color.yellow.rgbaColor,
              title: "Odmor",
              tasks: [EventTask(text: "Kupiti kartu"),
                      EventTask(text: "Spremiti se"),
                      EventTask(text: "Bookirati izlet u Parizu"),
                     ],
              date: Date.roundedHoursFromNow(60 * 60 * 22)),
        Event(symbol: "heart.text.square.fill",
              color: Color.indigo.rgbaColor,
              title: "Sistematski kod doktora",
              tasks: [EventTask(text: "Ponijeti iskaznicu"),
                      EventTask(text: "Uraditi EKG"),
                     ],
              date: Date.roundedHoursFromNow(60 * 60 * 24 * 4)),
        Event(symbol: "leaf.fill",
              color: Color.green.rgbaColor,
              title: "Kampiranje na Blidinju",
              tasks: [EventTask(text: "Kupiti sprej za bube"),
                      EventTask(text: "Šator"),
                      EventTask(text: "Maramice"),
                      EventTask(text: "Hrana za 4 obroka"),
                      EventTask(text: "Vreća za spavanje"),
                     ],
              date: Date.roundedHoursFromNow(60 * 60 * 36)),
        Event(symbol: "gamecontroller.fill",
              color: Color.cyan.rgbaColor,
              title: "Večer igara",
              tasks: [EventTask(text: "Ponijeti Play Station"),
                      EventTask(text: "Kupiti slatkise"),
                     ],
              date: Date.roundedHoursFromNow(60 * 60 * 24 * 2)),
        Event(symbol: "graduationcap.fill",
              color: Color.primary.rgbaColor,
              title: "Prvi dan škole",
              tasks: [
                  EventTask(text: "Teke"),
                  EventTask(text: "Olovke"),
                  EventTask(text: "Pernica"),
                  EventTask(text: "Torba"),
              ],
              date: Date.roundedHoursFromNow(60 * 60 * 24 * 365 * 2)),
        Event(symbol: "globe.americas.fill",
              color: Color.gray.rgbaColor,
              title: "Odmor na Havajima",
              tasks: [
                  EventTask(text: "Kupiti peškire"),
                  EventTask(text: "Pregledati sobu"),
                  EventTask(text: "Kupiti magnete"),
                  EventTask(text: "Krema za sunčanje"),
              ],
              date: Date.from(month: 6, day: 7, year: 2021)),
        Event(symbol: "case.fill",
              color: Color.orange.rgbaColor,
              title: "Putovanje",
              tasks: [
                  EventTask(text: "Kupi karte za avion"),
                  EventTask(text: "Kupiti novi kupaći kostim"),
                  EventTask(text: "Pronaći apartman"),
              ],
              date: Date.roundedHoursFromNow(60 * 60 * 24 * 19)),
    ]
    
    func add(_ event: Event) {
        events.append(event)
    }
        
    func remove(_ event: Event) {
        events.removeAll { $0.id == event.id}
    }
    
    func sortedEvents(period: Period) -> Binding<[Event]> {
        Binding<[Event]>(
            get: {
                self.events
                    .filter { $0.period == period}
                    .sorted { $0.date < $1.date }
            },
            set: { events in
                for event in events {
                    if let index = self.events.firstIndex(where: { $0.id == event.id }) {
                        self.events[index] = event
                    }
                }
            }
        )
    }
    
    func getBindingToEvent(_ event: Event) -> Binding<Event>? {
        Binding<Event>(
            get: {
                guard let index = self.events.firstIndex(where: { $0.id == event.id }) else { return Event.delete }
                return self.events[index]
            },
            set: { event in
                guard let index = self.events.firstIndex(where: { $0.id == event.id }) else { return }
                self.events[index] = event
            }
        )
    }
    private static func getEventsFileURL() throws -> URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            .appendingPathComponent("events.data")
    }
    func load() {
        do {
            let fileURL = try EventData.getEventsFileURL()
            let data = try Data(contentsOf: fileURL)
            events = try JSONDecoder().decode([Event].self, from: data)
            print("Broj događaja: \(events.count)")
        } catch {
            print("Nemoguć učitati!")
        }
    }
    
    func save() {
        do {
            let fileURL = try EventData.getEventsFileURL()
            let data = try JSONEncoder().encode(events)
            try data.write(to: fileURL, options: [.atomic, .completeFileProtection])
            print("Sačuvani događaji")
        } catch {
            print("Nemoguće sačuvati!")
        }
    }
}

enum Period: String, CaseIterable, Identifiable {
    case nextSevenDays = "Narednih 7 dana"
    case nextThirtyDays = "Narednih 30 dana"
    case future = "Budućnost"
    case past = "Prošlost"
    
    var id: String { self.rawValue }
    var name: String { self.rawValue }
}

extension Date {
    static func from(month: Int, day: Int, year: Int) -> Date {
        var dateComponents = DateComponents()
        dateComponents.year = year
        dateComponents.month = month
        dateComponents.day = day
        
        let calendar = Calendar(identifier: .gregorian)
        if let date = calendar.date(from: dateComponents) {
            return date
        } else {
            return Date.now
        }
    }

    static func roundedHoursFromNow(_ hours: Double) -> Date {
        let exactDate = Date(timeIntervalSinceNow: hours)
        guard let hourRange = Calendar.current.dateInterval(of: .hour, for: exactDate) else {
            return exactDate
        }
        return hourRange.end
    }
}
