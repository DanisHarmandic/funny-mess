//
//  Location.swift
//  TravelFocus
//
//  Created by Danis Harmandic on 25. 12. 2022..
//

import Foundation

struct Location: Decodable, Identifiable {
    let id: Int
    let name: String
    let country: String
    let description: String
    let more:  String
    let latitude: Double
    let longitude: Double
    let heroPicture: String
    let advisory: String
    
    static let example = Location(id: 1, name: "Stari most", country: "Bosna i hercegovina", description: "Odlicno mjesto za posjetiti", more: "Vise teksta", latitude: 43.3373, longitude: 17.8150, heroPicture: "stari-most", advisory: "Pazi se visine")
}
