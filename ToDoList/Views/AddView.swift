//
//  AddView.swift
//  ToDoList
//
//  Created by Mahalakshmi Srinivasan on 15/01/24.
//

import SwiftUI

struct AddView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var listViewModel: ListViewModel
    @State var titleValue: String = ""
    @State var alertTile: String = ""
    @State var showAlert: Bool = false

    var body: some View {
        ScrollView {
            VStack {
                TextField("Type here ..", text: $titleValue)
                    .padding(.horizontal)
                    .frame(height: 55)
                    .background(Color(UIColor.secondarySystemBackground))
                    .cornerRadius(10)
                Button(action: saveButtonPressed, label: {
                    Text("Save".uppercased())
                        .foregroundColor(.white)
                        .font(.headline)
                        .frame(height: 55)
                        .frame(maxWidth: .infinity)
                        .background(Color.accentColor)
                        .cornerRadius(10)
                })
            }
            .padding(14)

        }
        .navigationTitle("Add Item")
        .alert(isPresented: $showAlert, content: getAlert)
    }

    func saveButtonPressed() {
        if isTextValid() {
            listViewModel.addItem(title: titleValue)
            presentationMode.wrappedValue.dismiss()
        }
    }

    func isTextValid() -> Bool {
        if titleValue.count < 3 {
            alertTile = "Title is not valid"
            showAlert.toggle()
            return false
        }
        return true
    }

    func getAlert() -> Alert {
        return Alert(title: Text(alertTile))
    }
}

#Preview {
    NavigationView {
        AddView()
    }
    .preferredColorScheme(.dark)
    .environmentObject(ListViewModel())
}
