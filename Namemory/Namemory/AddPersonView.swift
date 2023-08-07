//
//  AddPersonView.swift
//  Namemory
//
//  Created by Alex Nguyen on 2023-08-03.
//

import SwiftUI
import PhotosUI
import MapKit

struct AddPersonView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel = ViewModel()
    
    @ObservedObject var contactBook: ContactBook
    
    @State private var menuDiaglog = false
    @State private var showingPhotoPicker = false
    @State private var showingCameraPicker = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    if let uiPhoto = viewModel.uiPhoto {
                        Image(uiImage: uiPhoto)
                            .resizable()
                            .scaledToFill()
                    } else {
                        ZStack {
                            Rectangle()
                                .fill(.secondary)
                            
                            HStack {
                                Image(systemName: "photo")
                                Text("Select a photo")
                            }
                            .foregroundColor(.white)
                            .font(.headline)
                        }
                    }
                }
                .confirmationDialog("", isPresented: $menuDiaglog) {
                    Button {
                        showingPhotoPicker = true
                    } label: {
                        HStack {
                            Image(systemName: "photo")
                            Text("Photo")
                        }
                    }
                    
                    Button {
                        showingCameraPicker = true
                    } label: {
                        HStack {
                            Image(systemName: "camera")
                            Text("Camera")
                        }
                    }
                } message: {
                    Text("Choose an option")
                }
                .sheet(isPresented: $showingCameraPicker) {
                    CameraPicker(image: $viewModel.uiPhoto)
                }
                .frame(width: 225, height: 300)
                .clipped()
                .onTapGesture {
                    menuDiaglog = true
                    Task { @MainActor in
                        viewModel.loadLocation()
                    }
                }
                .photosPicker(isPresented: $showingPhotoPicker, selection: $viewModel.photoItem)
                
                TextField("Name", text: $viewModel.name)
                    .textFieldStyle(.roundedBorder)
                    .padding()
                
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
                            contactBook.people.append(Person(id: UUID(), name: viewModel.name, image: viewModel.uiPhoto!, location: viewModel.wrappedLocation))
                            
                            dismiss()
                        } else {
                            viewModel.showingAlert = true
                        }
                    }
                    .disabled(viewModel.name.isEmpty || viewModel.uiPhoto == nil)
                }
            }
            .onAppear {
                viewModel.locationFetcher.start()
            }
        }
    }
}

struct AddPersonView_Previews: PreviewProvider {
    static var previews: some View {
        AddPersonView(contactBook: ContactBook.example)
    }
}
