//
//  AssessmentViewModel.swift
//  Inspections
//
//  Created by ERP on 28/07/2024.
//

import Foundation
import Combine

class AssessmentViewModel: ObservableObject {
    @Published var questions: [Question] = []
    @Published var currentQuestionIndex: Int = 0
    @Published var selectedAnswerIndex: Int? = nil
    @Published var showAlert: Bool = false
    @Published var alertMessage: String = ""
    @Published var score: Int = 0
    @Published var showScore: Bool = false

    init() {
        loadQuestions()
    }

    func loadQuestions() {
        questions = [
            Question(
                questionText: "What is the capital of France?",
                answers: ["Berlin", "Madrid", "Paris", "Rome"],
                correctAnswerIndex: 2
            ),
            Question(
                questionText: "What is 2 + 2?",
                answers: ["3", "4"],
                correctAnswerIndex: 1
            ),
            Question(
                questionText: "What is the largest planet in our solar system?",
                answers: ["Earth", "Jupiter", "Mars", "Saturn"],
                correctAnswerIndex: 1
            )
        ]
    }

    func submitAnswer() {
        guard let selectedAnswerIndex = selectedAnswerIndex else {
            alertMessage = "Please select an answer."
            showAlert = true
            return
        }

        if selectedAnswerIndex == questions[currentQuestionIndex].correctAnswerIndex {
            score += 1
        }

        if currentQuestionIndex < questions.count - 1 {
            currentQuestionIndex += 1
            self.selectedAnswerIndex = nil
        } else {
            showScore = true
        }
    }

    func reset() {
        score = 0
        currentQuestionIndex = 0
        selectedAnswerIndex = nil
        showScore = false
    }
}


