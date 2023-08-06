//
//  ContentView.swift
//  Namemory
//
//  Created by Alex Nguyen on 2023-08-02.
//

import SwiftUI

struct ContentView: View {
    @State private var showingAddPerson = false
    @StateObject var contactBook = ContactBook()
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(contactBook.people) { person in
                    NavigationLink {
                        PersonView(person: person)
                    } label: {
                        HStack {
                            // contact photos taken by the Camera app will have 3:4 ratio by default
                            Image(uiImage: person.image)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 75, height: 100)
                                .clipped()
                            
                            Text(person.name)
                                .font(.headline)
                        }
                    }                    
                }
                .onDelete(perform: contactBook.removeContacts)
            }
            .navigationTitle("People")
            .navigationBarTitleDisplayMode(.automatic)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showingAddPerson = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
                
            }
            .sheet(isPresented: $showingAddPerson) {
                AddPersonView(contactBook: contactBook)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
