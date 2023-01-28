//
//  Tips.swift
//  TravelFocus
//
//  Created by Danis Harmandic on 27. 12. 2022..
//

import SwiftUI

struct Tips: View {
    let tips: [Tip]
    
    init() {
        let url = Bundle.main.url(forResource: "tips_hrv", withExtension: "json")!
        let data = try! Data(contentsOf: url)
        tips = try! JSONDecoder().decode([Tip].self, from: data)
    }
    
    var body: some View {
        List(tips, id: \.text) { tip in
            if tip.children != nil {
                Label(tip.text, systemImage: "quote.bubble")
                    .font(.headline)
            } else {
                Text(tip.text)
            }
        }
        .navigationTitle("Tips")
    }
}

struct Tips_Previews: PreviewProvider {
    static var previews: some View {
        Tips()
    }
}
