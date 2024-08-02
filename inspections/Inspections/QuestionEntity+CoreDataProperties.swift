//
//  QuestionEntity+CoreDataProperties.swift
//  Inspections
//
//  Created by ERP on 29/07/2024.
//
//

import Foundation
import CoreData


extension QuestionEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<QuestionEntity> {
        return NSFetchRequest<QuestionEntity>(entityName: "QuestionEntity")
    }

    @NSManaged public var id: Int32
    @NSManaged public var name: String?
    @NSManaged public var selectedAnswerChoiceId: Int32
    @NSManaged public var answerChoices: NSSet?
    @NSManaged public var category: CategoryEntity?

}

// MARK: Generated accessors for answerChoices
extension QuestionEntity {

    @objc(addAnswerChoicesObject:)
    @NSManaged public func addToAnswerChoices(_ value: AnswerChoiceEntity)

    @objc(removeAnswerChoicesObject:)
    @NSManaged public func removeFromAnswerChoices(_ value: AnswerChoiceEntity)

    @objc(addAnswerChoices:)
    @NSManaged public func addToAnswerChoices(_ values: NSSet)

    @objc(removeAnswerChoices:)
    @NSManaged public func removeFromAnswerChoices(_ values: NSSet)

}

extension QuestionEntity : Identifiable {

}
