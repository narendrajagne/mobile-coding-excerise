//
//  TestViewModel.swift
//  Inspections
//
//  Created by ERP on 29/07/2024.
//
import SwiftUI
import CoreData

class TestViewModel: ObservableObject {
    @Published var questions: [QuestionEntity] = []
    var inspectionData: InspectionData = InspectionData(inspection: Inspection(area: Area(id: 0, name: ""), id: 0, inspectionType: InspectionType(access: "", id: 0, name: ""), survey: Survey(categories: [Category(id: 0, name: "", questions: [Question(answerChoices: [AnswerChoice(id: 0, name: "", score: 0.0)], id: 0, name: "", selectedAnswerChoiceId: 0)])], id: 0)))
    @Published var currentQuestionIndex = 0
    @Published var showAlert: Bool = false
    @Published var alertMessage: String = ""
    @Published var isPreBtnVisible = true
    @Published var inspectionModel: InspectionData?
    @Published var showSuccessView: Bool = false


    var currentQuestion: QuestionEntity? {
        questions.isEmpty ? nil : questions[currentQuestionIndex]
    }
    
    var totalQuestions: Int {
        questions.count
    }
    
    var progress: Double {
        Double(currentQuestionIndex + 1) / Double(totalQuestions)
    }

    init() {
        fetchQuestions()
    }

    func fetchQuestions() {
        DispatchQueue.main.async {
            if let inspectionData = DataManager.shared.fetchInspectionData() {
                for data in inspectionData {
                    if let categories = data.categories as? Set<CategoryEntity> {
                        for category in categories {
                            if let questionsArray = category.questions?.allObjects as? [QuestionEntity] {
                                self.questions.append(contentsOf: questionsArray)
                            }
                        }
                    }
                }
            }
        }
    }
    
    func submitAnswer(selectedAnswerId: Int, inspectionModel: InspectionData) {
        self.inspectionData = inspectionModel
        guard let question = currentQuestion else { return }
        for (index, categories) in self.inspectionData.inspection.survey.categories.enumerated() {
            for (index1, _) in categories.questions.enumerated() {
                if categories.questions.firstIndex(where: {$0.id == question.id}) != nil {
                    self.inspectionData.inspection.survey.categories[index].questions[index1].selectedAnswerChoiceId = selectedAnswerId
                }
            }
        }
        question.selectedAnswerChoiceId = Int32(selectedAnswerId)
        do {
            try DataManager.shared.persistentContainer.viewContext.save()
            nextQuestion()
        } catch {
            print("Failed to save selected answer: \(error)")
        }
    }

    func nextQuestion() {
        saveCurrentQuestion()
        if currentQuestionIndex < questions.count - 1 {
            currentQuestionIndex += 1
        } else if currentQuestionIndex == questions.count - 1 {
            isPreBtnVisible = false
        }
    }

    func previousQuestion() {
        saveCurrentQuestion()
        if currentQuestionIndex > 0 {
            currentQuestionIndex -= 1
        }
    }

    func saveCurrentQuestion() {
        DispatchQueue.main.async {
            guard self.currentQuestion != nil else { return }
            do {
                try DataManager.shared.persistentContainer.viewContext.save()
            } catch {
                print("Failed to save question: \(error)")
            }
        }
    }
    
    func submitInspectionAPI() {
        do {
            let datat = try convertModelToData(inspectionData: self.inspectionData)
            NetworkManager.shared.sendPostRequest(urlString: "http://localhost:5001/api/inspections/submit", data: datat) { result in
                switch result {
                case .success(_):
                    self.showSuccessView = true
                case .failure(let error):
                    // Handle error
                    self.showSuccessView = false
                    print(error)
                }
            }
        } catch {
            self.showSuccessView = false
        }
    }
    
    func convertModelToData(inspectionData: InspectionData) throws -> Data {
        let encoder = JSONEncoder()
        let data = try encoder.encode(inspectionData)
        return data
    }
}

