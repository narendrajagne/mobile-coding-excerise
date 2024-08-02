//
//  LoginView.swift
//  Inspections
//
//  Created by ERP on 27/07/2024.
//

import SwiftUI

struct LoginView: View {
    @State private var showRegister: Bool = false
    @StateObject var viewModel = LoginViewModel()
    @ObservedObject var testviewModel: TestViewModel
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Login")
                    .font(.largeTitle)
                    .padding()
                TextField("Username", text: $viewModel.email)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(5.0)
                    .padding(.bottom, 20)
                SecureField("Password", text: $viewModel.password)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(5.0)
                    .padding(.bottom, 20)
                if viewModel.isLoading {
                    ProgressView()
                        .padding()
                } else {
                    Button(action: {
                        viewModel.userLogin()
                    }, label: {
                        Text("Login")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(width: 220, height: 60)
                            .background(Color.green)
                            .cornerRadius(15.0)
                    })
                    .alert(isPresented: $viewModel.showAlert) {
                        Alert(title: Text("Login Success"), message: Text(viewModel.alertMessage))
                    }
                }
                Button(action: {
                    showRegister = true
                }) {
                    Text("Registration")
                        .font(.headline)
                        .foregroundColor(Color.green)
                        .underline()
                        .padding()
                        .frame(width: 200, height: 30)
                        .cornerRadius(15.0)
                        .padding(.top, 10)
                }
                .sheet(isPresented: $showRegister) {
                    RegistrationView()
                }
            }
            .padding()
            .navigationDestination(isPresented: $viewModel.isAuthenticated) {
                StartTestView(viewModel: testviewModel)
            }
        }
    }
}
