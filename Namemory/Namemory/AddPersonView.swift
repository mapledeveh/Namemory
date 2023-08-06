//
//  AddPersonView.swift
//  Namemory
//
//  Created by Alex Nguyen on 2023-08-03.
//

import SwiftUI
import PhotosUI

struct AddPersonView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel = ViewModel()
    
    @ObservedObject var contactBook: ContactBook
    
    var body: some View {
        NavigationView {
            VStack {
                PhotosPicker(selection: $viewModel.photoItem, matching: .images) {
                    ZStack {
                        Rectangle()
                            .fill(.secondary)
                        
                        Text("Select Photo")
                            .foregroundColor(.white)
                            .font(.headline)
                        
                        if let uiImage = viewModel.uiPhoto {
                            Image(uiImage: uiImage)
                                .resizable()
                                .scaledToFill()
                        }
                    }
                }
                .frame(width: 300, height: 400)
                .clipped()
                
                Form {
                    TextField("Name", text: $viewModel.name)
                }
                .disabled(viewModel.uiPhoto == nil)
            }
            .padding()
            .navigationTitle("Add Person")
            .alert("Error", isPresented: $viewModel.showingAlert) {
                Button("OK") { }
            } message: {
                Text(viewModel.alertMessage)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel", role: .cancel) {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        if viewModel.name.trimmingCharacters(in: .whitespacesAndNewlines) != "" && viewModel.uiPhoto != nil {
                            contactBook.people.append(Person(id: UUID(), name: viewModel.name, image: viewModel.uiPhoto!))
                            
                            dismiss()
                        } else {
                            viewModel.showingAlert = true
                        }
                    }
                    .disabled(viewModel.name.isEmpty || viewModel.uiPhoto == nil)
                }
            }
            .onChange(of: viewModel.photoItem) { _ in
                Task {
                    await viewModel.loadImage()
                }
            }
        }
    }
}

struct AddPersonView_Previews: PreviewProvider {
    static var previews: some View {
        AddPersonView(contactBook: ContactBook.example)
    }
}
