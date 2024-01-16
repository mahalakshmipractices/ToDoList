//
//  ToDoListApp.swift
//  ToDoList
//
//  Created by Mahalakshmi Srinivasan on 04/01/24.
//

import SwiftUI

@main
struct ToDoListApp: App {

    @StateObject var listViewModel: ListViewModel = ListViewModel()

    var body: some Scene {
        WindowGroup {
            //ContentView()
            //SimpleTableView()
            //CustomNavigationBar()
            //RegistrationFormView()
            //APIUsingCombine()
            NavigationView {
                ListView()
            }
            .navigationViewStyle(StackNavigationViewStyle())
            .environmentObject(listViewModel)
        }
    }
}
