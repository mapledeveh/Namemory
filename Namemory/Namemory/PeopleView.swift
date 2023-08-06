//
//  PeopleView.swift
//  Namemory
//
//  Created by Alex Nguyen on 2023-08-03.
//

import SwiftUI
import PhotosUI

struct AddPersonView: View {
    @StateObject var viewModel = ViewModel()
    
    var body: some View {
        VStack {
            PhotosPicker("Select Photo", selection: $viewModel.photoItem, matching: .images)
                .buttonStyle(.borderedProminent)
            
            if let photoImage = viewModel.photoImage {
                photoImage
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300, height: 300)
            }
        }
        .navigationTitle("People")
        
        .onChange(of: viewModel.photoItem) { _ in
            Task {
                await viewModel.loadImage()
            }
        }
    }
}

struct PeopleView_Previews: PreviewProvider {
    static var previews: some View {
        AddPersonView()
    }
}
