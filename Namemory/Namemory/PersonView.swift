//
//  PersonView.swift
//  Namemory
//
//  Created by Alex Nguyen on 2023-08-06.
//

import SwiftUI
import MapKit

struct PersonView: View {
    var person: Person
    @State private var mapLocation = MKCoordinateRegion()
    
    var body: some View {
        VStack {
            Image(uiImage: person.image)
                .resizable()
                .scaledToFit()
            
            Text(person.name)
                .font(.largeTitle)
            
            Map(coordinateRegion: $mapLocation, annotationItems: [person]) { person in
                MapAnnotation(coordinate: person.location) {
                    VStack {
                        Image(systemName: "person.fill")
                            .font(.system(size: 32))
                            .foregroundColor(.blue)
                        
                        Text(person.name)
                            .font(.headline)
                    }
                }
            }
        }
        .onAppear {
            mapLocation = MKCoordinateRegion(center: person.location, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
        }
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct PersonView_Previews: PreviewProvider {
    static var previews: some View {
        PersonView(person: Person.example)
    }
}
