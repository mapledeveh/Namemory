//
//  PhotoPickerView.swift
//  Namemory
//
//  Created by Alex Nguyen on 2023-08-03.
//

import SwiftUI
import PhotosUI

struct PhotoPickerView: View {
    @State private var photoItem: PhotosPickerItem?
    @State private var photoImage: Image?
    
    var body: some View {
        VStack {
            PhotosPicker("Select Photo", selection: $photoItem, matching: .images)
                .buttonStyle(.borderedProminent)
            
            if let photoImage {
                photoImage
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300, height: 300)
            }
        }
        .onChange(of: photoItem) { _ in
            Task {
                if let data = try? await photoItem?.loadTransferable(type: Data.self) {
                    if let uiImage = UIImage(data: data) {
                        photoImage = Image(uiImage: uiImage)
                        return
                    }
                }
                
                print("Failed")
            }
        }
    }
}

struct PhotoPickerView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoPickerView()
    }
}
