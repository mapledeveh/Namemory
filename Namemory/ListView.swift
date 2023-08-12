//
//  MainView.swift
//  Namemory
//
//  Created by Alex Nguyen on 2023-08-06.
//

import SwiftUI

struct ListView: View {
    @ObservedObject var contactBook: ContactBook
    
    var body: some View {
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
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        ListView(contactBook: ContactBook.example)
    }
}
