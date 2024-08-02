//
//  StartTestView.swift
//  Inspections
//
//  Created by ERP on 29/07/2024.
//

import SwiftUI

struct StartTestView: View {
    @AppStorage("isStartTest") private var isStartTest = false
    @State private var showTest: Bool = false
    @ObservedObject var viewModel: TestViewModel
    
    var body: some View {
        NavigationStack {
            Button(action: {
                callGetAPI()
            }, label: {
                Text("START-TEST")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: 220, height: 60)
                    .background(Color.green)
                    .cornerRadius(15.0)
            })
            .padding()
            .navigationDestination(isPresented: $showTest) {
                TestView(viewModel: viewModel)
            }
        }
        .navigationBarBackButtonHidden()
    }
    
     func callGetAPI() {
        NetworkManager.shared.fetchInspectionData(url: "http://localhost:5001/api/inspections/start") { result in
            switch result {
            case .success(let inspectionData):
                viewModel.inspectionModel = inspectionData
                DataManager.shared.saveInspectionData(inspectionData: inspectionData)
                viewModel.fetchQuestions()
                showTest = true
                isStartTest = true
            case .failure(let error):
                print("Failed to fetch inspection data: \(error)")
            }
        }
    }
}
