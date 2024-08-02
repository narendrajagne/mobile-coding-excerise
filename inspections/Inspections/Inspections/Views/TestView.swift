//
//  TestView.swift
//  Inspections
//
//  Created by ERP on 29/07/2024.
//

import SwiftUI

struct TestView: View {
    @ObservedObject var viewModel: TestViewModel
    
    var body: some View {
        NavigationStack {
            VStack {
                if let currentQuestion = viewModel.currentQuestion {
                    Text("Question \(viewModel.currentQuestionIndex + 1) of \(viewModel.totalQuestions)")
                        .font(.headline)
                        .padding()
                    
                    ProgressBar(value: Double(viewModel.currentQuestionIndex + 1), total: Double(viewModel.totalQuestions))
                        .padding()
                    
                    Text(currentQuestion.name ?? "")
                        .font(.title)
                        .padding()
                    
                    ForEach(currentQuestion.answerChoices?.allObjects as? [AnswerChoiceEntity] ?? [], id: \.id) { answerChoice in
                        Button(action: {
                            if let model = viewModel.inspectionModel {
                                viewModel.submitAnswer(selectedAnswerId: Int(answerChoice.id), inspectionModel: model)
                            }
                        }) {
                            Text(answerChoice.name ?? "")
                                .padding()
                                .background(viewModel.currentQuestion?.selectedAnswerChoiceId == answerChoice.id ? Color.green : Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                                .padding(.bottom, 5)
                        }
                    }
                    
                    HStack {
                        Button(action: {
                            viewModel.previousQuestion()
                        }) {
                            Text("Previous")
                                .padding()
                                .background(Color.gray)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                        .disabled(viewModel.currentQuestionIndex == 0)
                        Spacer()
                        
                        Button(action: {
                            viewModel.nextQuestion()
                        }) {
                            Text("Next")
                                .padding()
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                        .disabled(viewModel.currentQuestionIndex == viewModel.totalQuestions - 1)
                    }
                    .padding()
                } else {
                    Text("Loading questions...")
                }
                Spacer()
                Button(action: {
                    viewModel.submitInspectionAPI()
                }) {
                    Text("Submit")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.green)
                        .cornerRadius(10)
                }.alert(isPresented: $viewModel.showSuccessView) {
                    Alert(title: Text("Success"), message: Text("Test Submited Successfully"))
                }
            }
            .padding()
        }
    }
}
