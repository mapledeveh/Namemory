//
//  GridView.swift
//  Namemory
//
//  Created by Alex Nguyen on 2023-08-07.
//

import SwiftUI

struct GridView: View {
    @ObservedObject var contactBook: ContactBook
    
    let collumns = [
        GridItem(.adaptive(minimum: 100))
    ]
    var body: some View {
        ScrollView {
            LazyVGrid(columns: collumns) {
                ForEach(contactBook.people) { person in
                    NavigationLink {
                        PersonView(person: person)
                    } label: {
                        VStack {
                            Image(uiImage: person.image)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 90, height: 120)
                                .clipped()
                            
                            Text(person.name)
                                .font(.headline)
                                .foregroundColor(.primary)
                        }
                        .padding(10)
                        .background(.ultraThinMaterial)
                        .clipShape(RoundedRectangle(cornerRadius: 5))
                    }
                }
            }
        }
        .padding()
    }
}

struct GridView_Previews: PreviewProvider {
    static var previews: some View {
        GridView(contactBook: ContactBook.example)
    }
}
