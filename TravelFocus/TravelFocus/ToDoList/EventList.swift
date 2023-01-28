//
//  EventList.swift
//  TravelFocus
//
//  Created by Danis Harmandic on 4. 1. 2023..
//

import SwiftUI

struct EventList: View {
    @ObservedObject var eventData: EventData

    @State private var isAddingNewEvent = false
    @State private var newEvent = Event()
    
    @State private var selection: Event?
    
    var body: some View {

        NavigationSplitView {

            List(selection: $selection) {
                ForEach(Period.allCases) { period in
                    Section(content: {
                        ForEach(eventData.sortedEvents(period: period)) { $event in
                            EventRow(event: event)
                                .tag(event)
                                .swipeActions {
                                    Button(role: .destructive) {
                                        selection = nil
                                        eventData.remove(event)
                                    } label: {
                                        Label("Izbriši", systemImage: "trash")
                                    }
                                }
                        }
                    }, header: {
                        Text(period.name)
                            .font(.callout)
                            .foregroundColor(.secondary)
                            .fontWeight(.bold)
                    })
                    .disabled(eventData.sortedEvents(period: period).isEmpty)
                }
            }
            .navigationTitle("Bilješke")
            .toolbar {
                ToolbarItem {
                    Button {
                        newEvent = Event()
                        isAddingNewEvent = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $isAddingNewEvent) {
                NavigationStack {
                    EventEditor(event: $newEvent, isNew: true)
                        .toolbar {
                               ToolbarItem(placement: .cancellationAction) {
                                   Button("Odustani") {
                                       isAddingNewEvent = false
                                   }
                               }
                               ToolbarItem {
                                   Button {
                                       eventData.add(newEvent)
                                       isAddingNewEvent = false
                                   } label: {
                                       Text("Dodaj" )
                                   }
                                   .disabled(newEvent.title.isEmpty)
                               }
                            }
                }
            }
        } detail: {
            ZStack {
                if let event = selection, let eventBinding = eventData.getBindingToEvent(event) {
                    EventEditor(event: eventBinding)
                } else {
                    Text("Izaberi događaj")
                        .foregroundStyle(.secondary)
                }
            }
        }
    }
}

struct EventList_Previews: PreviewProvider {
    static var previews: some View {
        EventList(eventData: EventData())
    }
}
