//
//  RegistrationView.swift
//  Inspections
//
//  Created by ERP on 27/07/2024.
//

import SwiftUI

struct RegistrationView: View {

    @StateObject var viewModel = RegisterViewModel()

    var body: some View {
        VStack {
            Text("Register")
                .font(.largeTitle)
                .padding()
            TextField("Email", text: $viewModel.email)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(5.0)
                .padding(.bottom, 20)
            SecureField("Password", text: $viewModel.password)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(5.0)
                .padding(.bottom, 20)
            SecureField("Confirm Password", text: $viewModel.confirmPassword)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(5.0)
                .padding(.bottom, 20)
            if viewModel.isLoading {
                ProgressView()
                    .padding()
            } else {
                Button(action: {
                    viewModel.userRegister()
                }) {
                    Text("Register")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 220, height: 60)
                        .background(Color.green)
                        .cornerRadius(15.0)
                }
                .alert(isPresented: $viewModel.showAlert) {
                    Alert(title: Text("Registration Error"), message: Text(viewModel.alertMessage))
                }
            }
        }
        .padding()
    }
}

#Preview {
    RegistrationView()
}
