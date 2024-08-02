//
//  InspectionModel.swift
//  Inspections
//
//  Created by ERP on 29/07/2024.
//

import Foundation
import Combine

struct InspectionData: Codable {
     var inspection: Inspection
}

struct Inspection: Codable {
    var area: Area
    var id: Int
    var inspectionType: InspectionType
    var survey: Survey
}

struct Area: Codable {
    var id: Int
    var name: String
}

struct InspectionType: Codable {
    var access: String
    var id: Int
    var name: String
}

struct Survey: Codable {
    var categories: [Category]
    var id: Int
}

struct Category: Codable {
    var id: Int
    var name: String
    var questions: [Question]
}

struct Question: Codable, Identifiable {
    var answerChoices: [AnswerChoice]
    var id: Int
    var name: String
    var selectedAnswerChoiceId: Int?
}

struct AnswerChoice: Codable, Identifiable {
    var id: Int
    var name: String
    var score: Double
}
