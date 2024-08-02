//
//  InspectionsApp.swift
//  Inspections
//
//  Created by ERP on 27/07/2024.
//

import SwiftUI

@main
struct InspectionsApp: App {
    
    let persistenceController = PersistenceController.shared
    @AppStorage("isStartTest") private var isStartTest = false
    @StateObject private var viewModel = TestViewModel()
    var body: some Scene {
        WindowGroup {
            if isStartTest {
                TestView(viewModel: viewModel)
            } else {
                LoginView(testviewModel: viewModel)
            }
        }
    }
}
