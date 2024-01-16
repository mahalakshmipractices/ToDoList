//
//  SimpleTableView.swift
//  ToDoList
//
//  Created by Mahalakshmi Srinivasan on 05/01/24.
//

import SwiftUI

struct SimpleTableView: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("Your Content Here")
                    .padding()

                // Additional content goes here
            }
            .navigationBarTitle("Your Title", displayMode: .inline)
            // Additional navigation bar customization can be added here
        }
    }
}

struct SimpleTableView_Previews: PreviewProvider {
    static var previews: some View {
        SimpleTableView()
    }
}


