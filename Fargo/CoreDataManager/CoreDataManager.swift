//
//  CoreDataManager.swift
//  Fargo
//
//  Created by Elvina Jacia on 20/07/22.
//

import CoreData
import UIKit

final class CoreDataManager{
    lazy var persistenContainer: NSPersistentContainer = {
        let persistenContainer = NSPersistentContainer(name: "Fargo")
        persistenContainer.loadPersistentStores{ _, error in
            print(error?.localizedDescription ?? "")
        }
     return persistenContainer
   
    } ()
    
    var manageObjContext: NSManagedObjectContext{
        persistenContainer.viewContext
    }
    
    //MARK: -- SAVE DATA FUNCTION

    func saveGoal(goalDesc: String, reason: String){
        
        let goal = Goal(context: manageObjContext)
        goal.setValue(goalDesc, forKey: "goalDesc")
        goal.setValue(reason, forKey: "reason")
        
        do {
            try manageObjContext.save()
        } catch {
            print(error)
        }
        
    }
    
    func saveRequirement(requirementTitle: String){
        
        let requirement = Requirement(context: manageObjContext)
        requirement.setValue(requirementTitle, forKey: "requirementTitle")
       
        do {
            try manageObjContext.save()
        } catch {
            print(error)
        }
        
    }
    
    func saveActionPlan(actionName: String, actionDesc: String, successParameter: String, learningResources: String, startDate: Date, endDate: Date){
        
        let requirement = Requirement(context: manageObjContext)
//Harus ambil nama requirement dari tableViewtext yang di select
        
        
        let actionPlan = ActionPlan(context: manageObjContext)
        actionPlan.setValue(actionName, forKey: "actionName")
        actionPlan.setValue(actionDesc, forKey: "actionDesc")
        actionPlan.setValue(successParameter, forKey: "successParameter")
        actionPlan.setValue(learningResources, forKey: "learningResources")
        actionPlan.setValue(startDate, forKey: "startDate")
        actionPlan.setValue(endDate, forKey: "endDate")
        
        //Add actionPlan to Requirement
        requirement.addToActionPlan(actionPlan)
        
        do {
            try manageObjContext.save()
        } catch {
            print(error)
        }
        
    }
   
    //MARK: -- FETCH DATA FUNCTION
    
    func fetchGoal() -> [Goal]{
        
        do{
            let fetchRequest = NSFetchRequest<Goal>(entityName: "Goal")
            let goal = try manageObjContext.fetch(fetchRequest)
            return goal
        } catch {
            print(error)
            return []
        }
    
    }
    
    func fetchRequirement() -> [Requirement]{
        
        do{
            let fetchRequest = NSFetchRequest<Requirement>(entityName: "Requirement")
            let requirement = try manageObjContext.fetch(fetchRequest)
            return requirement
        } catch {
            print(error)
            return []
        }
    
    }
    
    func fetchActionPlan() -> [Requirement]{
        
        do{
            let fetchRequest = NSFetchRequest<Requirement>(entityName: "Requirement")
            let requirement = try manageObjContext.fetch(fetchRequest)
            return requirement
        } catch {
            print(error)
            return []
        }
    
    }
    
    
}
