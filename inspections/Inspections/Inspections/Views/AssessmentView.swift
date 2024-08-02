//
//  AssessmentView.swift
//  Inspections
//
//  Created by ERP on 28/07/2024.
//
import SwiftUI
import CoreData

struct AssessmentView: View {
//    @StateObject private var viewModel: QuestionsViewModel
//
//    init(context: NSManagedObjectContext) {
//        _viewModel = StateObject(wrappedValue: QuestionsViewModel(context: context))
//    }

    var body: some View {
        Text("Submit Test")
        
//        NavigationStack {
//            VStack {
//                if viewModel.showScore {
//                    Text("Your score is \(viewModel.score) out of \(viewModel.questions.count)")
//                        .font(.largeTitle)
//                        .padding()
//                    
//                    Button(action: {
//                        viewModel.reset()
//                    }) {
//                        Text("Submit Test")
//                            .font(.headline)
//                            .foregroundColor(.white)
//                            .padding()
//                            .frame(maxWidth: .infinity)
//                            .background(Color.green)
//                            .cornerRadius(10)
//                    }
//                    .padding()
//                } else {
//                    if viewModel.questions.count > 0 {
//                        Text("Question \(viewModel.currentQuestionIndex + 1) of \(viewModel.questions.count)")
//                                        .font(.headline)
//                                        .padding()
//                        ProgressBar(value: Double(viewModel.currentQuestionIndex + 1), total: Double(viewModel.questions.count))
//                            .padding()
//                        Text(viewModel.questions[viewModel.currentQuestionIndex].name)
//                            .font(.title)
//                            .padding()
//                        
//                        ForEach(viewModel.questions[viewModel.currentQuestionIndex].answerChoices) { answerChoice in
//                            AnswerButton(
//                                answerText: answerChoice.name,
//                                isSelected: viewModel.selectedAnswerIndex == answerChoice.id,
//                                action: {
//                                    viewModel.selectedAnswerIndex = answerChoice.id
//                                }
//                            )
//                        }
//                    }
//                    Button(action: {
//                        viewModel.submitAnswer()
//                    }) {
//                        Text("NEXT")
//                            .font(.headline)
//                            .foregroundColor(.white)
//                            .padding()
//                            .frame(maxWidth: .infinity)
//                            .background(Color.green)
//                            .cornerRadius(10)
//                    }
//                    .padding()
//                }
//            }
//            .padding()
//            .alert(isPresented: $viewModel.showAlert) {
//                Alert(title: Text("Error"), message: Text(viewModel.alertMessage), dismissButton: .default(Text("OK")))
//            }
//        }
//        .navigationBarBackButtonHidden()
    }
}

struct AssessmentView_Previews: PreviewProvider {
    static var previews: some View {
        AssessmentView()
            //context: PersistenceController.shared.container.viewContext)
    }
}
    
//struct AnswerButton: View {
//    let answerText: String
//    let isSelected: Bool
//    let action: () -> Void
//
//    var body: some View {
//        Button(action: action) {
//            Text(answerText)
//                .font(.headline)
//                .foregroundColor(isSelected ? .white : .black)
//                .padding()
//                .frame(maxWidth: .infinity)
//                .background(isSelected ? Color.green : Color.gray.opacity(0.2))
//                .cornerRadius(10)
//                .padding(.bottom, 5)
//        }
//    }
//}
