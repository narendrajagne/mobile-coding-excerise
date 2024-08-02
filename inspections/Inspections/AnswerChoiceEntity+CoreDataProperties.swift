//
//  AnswerChoiceEntity+CoreDataProperties.swift
//  Inspections
//
//  Created by ERP on 29/07/2024.
//
//

import Foundation
import CoreData


extension AnswerChoiceEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<AnswerChoiceEntity> {
        return NSFetchRequest<AnswerChoiceEntity>(entityName: "AnswerChoiceEntity")
    }

    @NSManaged public var id: Int32
    @NSManaged public var name: String?
    @NSManaged public var score: Float
    @NSManaged public var question: QuestionEntity?

}

extension AnswerChoiceEntity : Identifiable {

}
