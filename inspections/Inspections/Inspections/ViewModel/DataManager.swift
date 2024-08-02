//
//  DataManager.swift
//  Inspections
//
//  Created by ERP on 29/07/2024.
//

import CoreData

class DataManager {
    static let shared = DataManager()
    let persistentContainer: NSPersistentContainer

    private init() {
        persistentContainer = NSPersistentContainer(name: "Inspections")
        persistentContainer.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Failed to load Core Data stack: \(error)")
            }
        }
    }

    func saveInspectionData(inspectionData: InspectionData) {
        let context = persistentContainer.viewContext

        let inspectionEntity = InspectionEntity(context: context)
        inspectionEntity.id = Int32(inspectionData.inspection.id)
        inspectionEntity.areaName = inspectionData.inspection.area.name

        for categoryData in inspectionData.inspection.survey.categories {
            let categoryEntity = CategoryEntity(context: context)
            categoryEntity.id = Int32(categoryData.id)
            categoryEntity.name = categoryData.name

            for questionData in categoryData.questions {
                let questionEntity = QuestionEntity(context: context)
                questionEntity.id = Int32(questionData.id)
                questionEntity.name = questionData.name
                questionEntity.selectedAnswerChoiceId = questionData.selectedAnswerChoiceId.map { Int32($0) } ?? 0

                for answerChoiceData in questionData.answerChoices {
                    let answerChoiceEntity = AnswerChoiceEntity(context: context)
                    answerChoiceEntity.id = Int32(answerChoiceData.id)
                    answerChoiceEntity.name = answerChoiceData.name
                    answerChoiceEntity.score = Float(answerChoiceData.score)
                    questionEntity.addToAnswerChoices(answerChoiceEntity)
                }
                categoryEntity.addToQuestions(questionEntity)
            }
            inspectionEntity.addToCategories(categoryEntity)
        }

        do {
            try context.save()
        } catch {
            print("Failed to save inspection data: \(error)")
        }
    }

    func fetchInspectionData() -> [InspectionEntity]? {
        let context = persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<InspectionEntity> = InspectionEntity.fetchRequest()

        do {
            return try context.fetch(fetchRequest)
        } catch {
            print("Failed to fetch inspection data: \(error)")
            return nil
        }
    }
}

