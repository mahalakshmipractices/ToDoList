//
//  CustomNavigationBar.swift
//  ToDoList
//
//  Created by Mahalakshmi Srinivasan on 05/01/24.
//

import SwiftUI
import SwiftUI

struct CustomNavigationBar: View {
//    var body: some View {
//        NavigationView {
//            VStack {
//                Text("Your Content Here")
//                    .padding()
//
//                // Additional content goes here
//            }
//            .navigationBarTitle("Your Title", displayMode: .inline)
//            .navigationBarItems(trailing:
//                HStack {
//                    Button(action: {
//                        // Add your action here
//                    }) {
//                        Image(systemName: "plus")
//                            .foregroundColor(.red)
//                    }
//                    Button(action: {
//                        // Add another action here
//                    }) {
//                        Image(systemName: "gear")
//                    }
//                }
//            )
//            .navigationBarItems(leading:
//                HStack {
//                    Button(action: {
//                        // Add your action here
//                    }) {
//                        Image(systemName: "plus")
//                    }
//                }
//            )
//            .navigationBarColor(backgroundColor: .gray, titleColor: .white, tintColor: .white)
//            // Additional navigation bar customization can be added here
//        }
//    }
    var body: some View {
            NavigationView {
                VStack {
                    CustomNavigation(title: "Page 1", action1: {
                        // Action for button 1 in ContentView1
                    }, action2: {
                        // Action for button 2 in ContentView1
                    })

                    // Content specific to ContentView1
                    Text("Page 1 Content")
                }
            }
        }
}

// Extension to customize navigation bar colors
extension View {
    func navigationBarColor(backgroundColor: UIColor, titleColor: UIColor, tintColor: UIColor) -> some View {
        self.modifier(NavigationBarColorModifier(backgroundColor: backgroundColor, titleColor: titleColor, tintColor: tintColor))
    }
}

struct NavigationBarColorModifier: ViewModifier {
    var backgroundColor: UIColor
    var titleColor: UIColor
    var tintColor: UIColor

    init(backgroundColor: UIColor, titleColor: UIColor, tintColor: UIColor) {
        self.backgroundColor = backgroundColor
        self.titleColor = titleColor
        self.tintColor = tintColor

        let coloredAppearance = UINavigationBarAppearance()
        coloredAppearance.backgroundColor = backgroundColor
        coloredAppearance.titleTextAttributes = [.foregroundColor: titleColor]
        coloredAppearance.largeTitleTextAttributes = [.foregroundColor: titleColor]

        UINavigationBar.appearance().standardAppearance = coloredAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = coloredAppearance
        UINavigationBar.appearance().compactAppearance = coloredAppearance
        UINavigationBar.appearance().tintColor = tintColor
    }

    func body(content: Content) -> some View {
        content
    }
}


struct CustomNavigation: View {
    var title: String
    var action1: () -> Void
    var action2: () -> Void

    var body: some View {
        HStack {
            Button(action: action1) {
                Image(systemName: "plus")
            }
            .padding()

            Spacer()

            Text(title)
                .font(.headline)

            Spacer()

            Button(action: action2) {
                Image(systemName: "gear")
            }
            .padding()
        }
        .padding(.horizontal)
        .background(Color.blue)
        .foregroundColor(.white)
        .shadow(color: Color.gray, radius: 2, x: 0, y: 1)
    }
}


struct CustomNavigationBar_Previews: PreviewProvider {
    static var previews: some View {
        CustomNavigationBar()
    }
}
