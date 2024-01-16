//
//  RegistrationFormView.swift
//  ToDoList
//
//  Created by Mahalakshmi Srinivasan on 08/01/24.
//

import SwiftUI

import SwiftUI
import Combine

enum Gender: String, CaseIterable {
    case male = "Male"
    case female = "Female"
    case other = "Other"
}

class RegistrationViewModel: ObservableObject {
    @Published var username: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var confirmPassword: String = ""
    //@Published var selectedGender: Gender?

    @Published var isUsernameValid: Bool = true
    @Published var isEmailValid: Bool = true
    @Published var isPasswordValid: Bool = true
    @Published var isConfirmPasswordValid: Bool = true
    //@Published var isGenderSelected: Bool = false

    private var cancellables: Set<AnyCancellable> = []

    init() {
        // Set up Combine publishers for validation
        $username
            .map { !$0.isEmpty }
            .assign(to: \.isUsernameValid, on: self)
            .store(in: &cancellables)

        $email
            .map { $0.isValidEmail() && $0.count > 10 }
            .assign(to: \.isEmailValid, on: self)
            .store(in: &cancellables)

        $password
            .map { $0.count >= 6 }
            .assign(to: \.isPasswordValid, on: self)
            .store(in: &cancellables)

        Publishers.CombineLatest($password, $confirmPassword)
            .map { password, confirmPassword in
                confirmPassword == password
            }
            .assign(to: \.isConfirmPasswordValid, on: self)
            .store(in: &cancellables)
//        $selectedGender
//            .map { $0 != nil }
//            .assign(to: \.isGenderSelected, on: self)
//            .store(in: &cancellables)
    }
}

struct ValidatedTextField: View {
    @Binding var text: String
    var placeholder: String
    @Binding var isValid: Bool

    var body: some View {
        TextField(placeholder, text: $text)
            .padding()
            .background(isValid ? Color.white : Color.red.opacity(0.3))
            .cornerRadius(5.0)
    }
}

struct RegistrationFormView: View {
    @StateObject private var viewModel = RegistrationViewModel()

    var body: some View {
        VStack {
            ValidatedTextField(text: $viewModel.username, placeholder: "Username", isValid: $viewModel.isUsernameValid)
                .padding(.bottom, 10)

            ValidatedTextField(text: $viewModel.email, placeholder: "Email", isValid: $viewModel.isEmailValid)
                .padding(.bottom, 10)

            ValidatedTextField(text: $viewModel.password, placeholder: "Password", isValid: $viewModel.isPasswordValid)
                .padding(.bottom, 10)

            ValidatedTextField(text: $viewModel.confirmPassword, placeholder: "Confirm Password", isValid: $viewModel.isConfirmPasswordValid)
                .padding(.bottom, 10)

//            Picker("Gender", selection: $viewModel.selectedGender) {
//                            ForEach(Gender.allCases, id: \.self) { gender in
//                                Text(gender.rawValue)
//                            }
//                        }
//                        .padding(.bottom, 10)

            Button(action: {
                // Simulate registration action
                register()
            }) {
                Text("Register")
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
        }
        .padding()
        .padding(.top, 50)
    }

    private func register() {
        // Perform registration logic here
        // You can check viewModel properties for validation status
        if viewModel.isUsernameValid && viewModel.isEmailValid && viewModel.isPasswordValid && viewModel.isConfirmPasswordValid {
            print("Registration successful!")
        } else {
            print("Please fill in the required fields correctly.")
        }
    }
}

extension String {
    func isValidEmail() -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: self)
    }
}

struct RegistrationFormView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationFormView()
    }
}
