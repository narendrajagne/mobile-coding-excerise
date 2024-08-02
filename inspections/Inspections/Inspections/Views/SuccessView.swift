//
//  SuccessView.swift
//  Inspections
//
//  Created by ERP on 29/07/2024.
//

import SwiftUI

struct SuccessView: View {
    @Environment(\.presentationMode) var presentationMode
    @AppStorage("isStartTest") private var isStartTest = false
    
    var body: some View {
        NavigationStack {
            VStack {
                Image(systemName: "checkmark.circle.fill")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .foregroundColor(.green)
                    .padding()
                
                Text("Success!")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding()
                
                Text("Your answers have been successfully submitted.")
                    .font(.title3)
                    .multilineTextAlignment(.center)
                    .padding()
                
                Button(action: {
                    isStartTest = false
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Text("OK")
                        .font(.title2)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding()
            }
        }
        .navigationTitle("Success")
        .navigationBarBackButtonHidden()
    }
}
