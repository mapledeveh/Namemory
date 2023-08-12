//
//  People.swift
//  Namemory
//
//  Created by Alex Nguyen on 2023-08-03.
//

import SwiftUI
import MapKit

struct Person: Identifiable, Codable {
    enum CodingKeys: CodingKey {
        case id, name, image, location
    }
    
    let id: UUID
    var name: String
    var image: UIImage
    var location: CLLocationCoordinate2D
    
    static let example = Person(id: UUID(), name: "John Doe", image: UIImage(systemName: "person")!, location: CLLocationCoordinate2D(latitude: 49, longitude: -72))
    
    init(id: UUID, name: String, image: UIImage, location: CLLocationCoordinate2D) {
        self.id = id
        self.name = name
        self.image = image
        self.location = location
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        if let jpegData = image.jpegData(compressionQuality: 0.8) {
            try? jpegData.write(to: FileManager.documentsDirectory.appendingPathComponent("avatar.jpg"), options: [.atomic, .completeFileProtection])
            try container.encode(jpegData, forKey: .image)
        }
        
        let coordinate = [location.latitude, location.longitude]
            
        try container.encode(coordinate, forKey: .location)
        
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decode(UUID.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        let imageData = try container.decode(Data.self, forKey: .image)
        image = UIImage(data: imageData)!
        let coordinate = try container.decode([Double].self, forKey: .location)
        location = CLLocationCoordinate2D(latitude: coordinate.first ?? 49.0, longitude: coordinate.last ?? -72.00)
    }
}

class ContactBook: ObservableObject {
    @Published var people = [Person]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(people) {
                UserDefaults.standard.set(encoded, forKey: "People")
            }
        }
    }
    
    init() {
        if let savedPeople = UserDefaults.standard.data(forKey: "People") {
            if let decodedPeople = try? JSONDecoder().decode([Person].self, from: savedPeople) {
                people = decodedPeople
                return
            }
        }
        
        people = []
    }
    
    static let example = ContactBook()
    
    func removeContacts(at offsets: IndexSet) {
        people.remove(atOffsets: offsets)
    }
}
