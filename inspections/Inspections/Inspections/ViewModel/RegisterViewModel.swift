//
//  RegisterViewModel.swift
//  Inspections
//
//  Created by ERP on 27/07/2024.
//

import Foundation
import Combine

class RegisterViewModel: ObservableObject {
        
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var confirmPassword: String = ""
    @Published var showAlert: Bool = false
    @Published var alertMessage: String = ""
    @Published var isLoading: Bool = false
    @Published var registrationSuccess: Bool = false
    
    func userRegister(){
        
        guard validateFields() else { return }
        isLoading = true
        DispatchQueue.global(qos: .background).async {
        let dict = ["email" : self.email, "password" :self.password]
        NetworkManager.shared.sendPostRequest(urlString: "http://localhost:5001/api/register", dictionary: dict) { result in
            switch result {
            case .success(_):
                DispatchQueue.main.async {
                    DispatchQueue.main.async {
                        self.isLoading = false
                        self.registrationSuccess = true
                    }
                }
            case .failure(let error):
                print(error)
            }
        }}
    }
    
    func validateFields() -> Bool {
        if !EmailValidation.isValidEmail(email) {
            alertMessage = "Invalid email address."
            showAlert = true
            return false
        } else if password != confirmPassword {
            alertMessage = "Passwords do not match."
            showAlert = true
            return false
        }
        return true
    }
}
