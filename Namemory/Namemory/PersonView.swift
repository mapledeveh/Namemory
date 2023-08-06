//
//  PersonView.swift
//  Namemory
//
//  Created by Alex Nguyen on 2023-08-06.
//

import SwiftUI

struct PersonView: View {
    var person: Person
    
    var body: some View {
        VStack {
            Image(uiImage: person.image)
                .resizable()
                .scaledToFit()
            
            Text(person.name)
                .font(.largeTitle)
            
            Spacer()
        }
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct PersonView_Previews: PreviewProvider {
    static var previews: some View {
        PersonView(person: Person.example)
    }
}
