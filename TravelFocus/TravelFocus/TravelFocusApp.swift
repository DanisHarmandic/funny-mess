//
//  TravelFocusApp.swift
//  TravelFocus
//
//  Created by Danis Harmandic on 22. 12. 2022..
//

import SwiftUI

@main
struct TravelFocusApp: App {
    @StateObject var locations = Locations()
    @State private var isLoggedIn = false
    
    var body: some Scene {
        
        WindowGroup {
            TabView {
                    NavigationView {
                        ContentView(location: locations.primary)
                    }
                    .tabItem {
                        Image(systemName: "airplane.circle.fill")
                        Text("Istražite")
                    }
                    
                    NavigationView {
                        WorldView()
                    }
                    .tabItem {
                        Image(systemName: "star.fill")
                        Text("Lokacije")
                    }
                    
                    NavigationView {
                        Tips()
                    }
                    .tabItem {
                        Image(systemName: "list.bullet")
                        Text("Savijeti")
                    }
                    
                    NavigationView {
                        EventList(eventData: EventData())
                    }
                    .tabItem {
                        Image(systemName: "list.bullet.clipboard.fill")
                        Text("Bilješke")
                    }
                
                NavigationView {
                    QuizView()
                }
                .tabItem {
                    Image(systemName: "globe.europe.africa.fill")
                    Text("Kviz")
                }
               
            }
            .environmentObject(locations)
        }
    }
}

