//
//  ContentView.swift
//  Namemory
//
//  Created by Alex Nguyen on 2023-08-07.
//

import SwiftUI

struct ContentView: View {
    @State private var showingList = false
    @State private var showingAddPerson = false
    @StateObject var contactBook = ContactBook()
    
    var body: some View {
        NavigationView {
            Group {
                if showingList {
                    ListView(contactBook: contactBook)
                } else {
                    GridView(contactBook: contactBook)
                }
            }
            .navigationTitle("People")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    if showingList {
                        HStack {
                            EditButton()
                            Button {
                                showingList = false
                            } label: {
                                Image(systemName: "square.grid.2x2")
                            }
                        }
                    } else {
                        Button("Show List") {
                            showingList = true
                        }
                    }
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
