//
//  ActionPlan+CoreDataProperties.swift
//  Fargo
//
//  Created by Elvina Jacia on 20/07/22.
//
//

import Foundation
import CoreData


extension ActionPlan {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ActionPlan> {
        return NSFetchRequest<ActionPlan>(entityName: "ActionPlan")
    }

    @NSManaged public var actionName: String?
    @NSManaged public var actionDesc: String?
    @NSManaged public var successParameter: String?
    @NSManaged public var learningResources: String?
    @NSManaged public var startDate: Date?
    @NSManaged public var endDate: Date?
    @NSManaged public var status: String?
    @NSManaged public var requirements: Requirement?

}

extension ActionPlan : Identifiable {

}
