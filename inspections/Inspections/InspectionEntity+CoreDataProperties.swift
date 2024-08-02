//
//  InspectionEntity+CoreDataProperties.swift
//  Inspections
//
//  Created by ERP on 29/07/2024.
//
//

import Foundation
import CoreData


extension InspectionEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<InspectionEntity> {
        return NSFetchRequest<InspectionEntity>(entityName: "InspectionEntity")
    }

    @NSManaged public var id: Int32
    @NSManaged public var areaName: String?
    @NSManaged public var categories: NSSet?

}

// MARK: Generated accessors for categories
extension InspectionEntity {

    @objc(addCategoriesObject:)
    @NSManaged public func addToCategories(_ value: CategoryEntity)

    @objc(removeCategoriesObject:)
    @NSManaged public func removeFromCategories(_ value: CategoryEntity)

    @objc(addCategories:)
    @NSManaged public func addToCategories(_ values: NSSet)

    @objc(removeCategories:)
    @NSManaged public func removeFromCategories(_ values: NSSet)

}

extension InspectionEntity : Identifiable {

}
