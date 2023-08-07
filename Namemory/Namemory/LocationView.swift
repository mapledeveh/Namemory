//
//  LocationView.swift
//  Namemory
//
//  Created by Alex Nguyen on 2023-08-06.
//

import SwiftUI
import MapKit

struct LocationView: View {
    let locationFetcher = LocationFetcher()
    @State private var mapLocation = MKCoordinateRegion()

    var body: some View {
        VStack {
            HStack {
                Button("Start Tracking Location") {
                    self.locationFetcher.start()
                }
                .buttonStyle(.bordered)
                
                Button("Read Location") {
                    if let location = self.locationFetcher.lastKnownLocation {
                        print("Your location is \(location)")
                        mapLocation = MKCoordinateRegion(center: location, span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
                    } else {
                        print("Your location is unknown")
                    }
                }
                .buttonStyle(.bordered)
            }
            
            Map(coordinateRegion: $mapLocation)
        }
    }
}

struct LocationView_Previews: PreviewProvider {
    static var previews: some View {
        LocationView()
    }
}
