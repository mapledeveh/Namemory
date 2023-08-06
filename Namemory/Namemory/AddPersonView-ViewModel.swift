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
        
        @Published var showingAlert = false
        @Published var alertMessage = "Photo and Name must not be empty!"
        
        init() {
            self.name = ""
        }
        
        func loadImage() async {
            if let data = try? await photoItem?.loadTransferable(type: Data.self) {
                if let uiImage = UIImage(data: data) {
                    uiPhoto = uiImage
                    return
                }
            }
            
            print("Failed")
        }
    }
}
