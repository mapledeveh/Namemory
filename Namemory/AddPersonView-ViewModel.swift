//
//  AddPersonView-ViewModel.swift
//  Namemory
//
//  Created by Alex Nguyen on 2023-08-03.
//

import SwiftUI
import PhotosUI

extension FileManager {
    static var documentsDirectory: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}

extension AddPersonView {
    @MainActor class ViewModel: ObservableObject {
        @Published var photoItem: PhotosPickerItem?
//        @Published var photoImage: Image?
        @Published var uiPhoto: UIImage?
        @Published var name: String
        @Published var location: CLLocationCoordinate2D?
        
        var wrappedLocation: CLLocationCoordinate2D {
            location ?? CLLocationCoordinate2D(latitude: 49.0, longitude: -72.00)
        }
        
        @Published var showingAlert = false
        @Published var alertMessage = "Photo and Name must not be empty!"
        
        let locationFetcher = LocationFetcher()
        
        init() {
            self.name = ""
        }
        
        func loadLocation() {
            if let mapLocation = locationFetcher.lastKnownLocation {
                print("Your location is \(mapLocation)")
                location = mapLocation
            } else {
                print("Your location is unknown")
                location = CLLocationCoordinate2D(latitude: 42.0, longitude: -79.00)
            }            
        }
        
        func loadImage() async {
            if let data = try? await photoItem?.loadTransferable(type: Data.self) {
                if let uiImage = UIImage(data: data) {
                    uiPhoto = uiImage
//                    loadLocation()
                    return
                }
            }
            
            print("Failed")
        }
    }
}
