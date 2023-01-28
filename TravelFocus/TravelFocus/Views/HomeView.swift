//
//  HomeView.swift
//  TravelFocus
//
//  Created by Danis Harmandic on 3. 1. 2023..
//

import SwiftUI

struct HomeView: View {
    @StateObject var locations = Locations()

    var body: some View {
        ContentView(location: locations.primary)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
