//
//  Goal+CoreDataProperties.swift
//  Fargo
//
//  Created by Elvina Jacia on 20/07/22.
//
//

import Foundation
import CoreData


extension Goal {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Goal> {
        return NSFetchRequest<Goal>(entityName: "Goal")
    }

    @NSManaged public var reason: String?
    @NSManaged public var goalDesc: String?
    @NSManaged public var requirement: NSSet?

}

// MARK: Generated accessors for requirement
extension Goal {
    //Add one req to the goal
    @objc(addRequirementObject:)
    @NSManaged public func addToRequirement(_ value: Requirement)

    @objc(removeRequirementObject:)
    @NSManaged public func removeFromRequirement(_ value: Requirement)
    
    //Add multiple req to the goal
    @objc(addRequirement:)
    @NSManaged public func addToRequirement(_ values: NSSet)

    @objc(removeRequirement:)
    @NSManaged public func removeFromRequirement(_ values: NSSet)

}

extension Goal : Identifiable {

}
