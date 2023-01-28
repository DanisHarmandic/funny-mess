//
//  Tip.swift
//  TravelFocus
//
//  Created by Danis Harmandic on 27. 12. 2022..
//

import Foundation

struct Tip: Decodable {
    let text: String
    let children: [Tip]?
}
