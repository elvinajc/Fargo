//
//  Requirement+CoreDataProperties.swift
//  Fargo
//
//  Created by Elvina Jacia on 20/07/22.
//
//

import Foundation
import CoreData


extension Requirement {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Requirement> {
        return NSFetchRequest<Requirement>(entityName: "Requirement")
    }

    @NSManaged public var requirementTitle: String?
    @NSManaged public var goal: Goal?
    @NSManaged public var actionPlan: NSSet?

}

// MARK: Generated accessors for actionPlan
extension Requirement {

    @objc(addActionPlanObject:)
    @NSManaged public func addToActionPlan(_ value: ActionPlan)

    @objc(removeActionPlanObject:)
    @NSManaged public func removeFromActionPlan(_ value: ActionPlan)

    @objc(addActionPlan:)
    @NSManaged public func addToActionPlan(_ values: NSSet)

    @objc(removeActionPlan:)
    @NSManaged public func removeFromActionPlan(_ values: NSSet)

}

extension Requirement : Identifiable {

}
