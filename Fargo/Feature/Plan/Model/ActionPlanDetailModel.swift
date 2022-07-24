//
//  ActionPlanDetailModel.swift
//  Fargo
//
//  Created by Elvina Jacia on 24/07/22.
//

//Section Title
enum ActPlanDetailCellSection: Int, CaseIterable,CustomStringConvertible{
    case actionNameTl
    case actionDescTl
    case successParameterTl
    case learningResourceTl
    case setDateTl
    
    
    var description: String{
        switch self {
            case.actionNameTl: return "Action Name"
            case.actionDescTl: return "Action Description"
            case.successParameterTl: return "What is the success looks like?"
            case.learningResourceTl: return "Learning Resources"
            case.setDateTl: return "Set Date"
        }
    }

}

//Act Name
enum ActionNameSect: Int, CaseIterable, CustomStringConvertible{
    case actionName
    
    var description: String{
        switch self {
        case.actionName: return "Action Name"
        }
    }
}

//Act Desc
enum ActionDescSect: Int, CaseIterable, CustomStringConvertible{
    case actionDesc
    
    var description: String{
        switch self {
        case.actionDesc: return "Action Description"
        }
    }
}

//Success Parameter
enum SuccessParamSect: Int, CaseIterable, CustomStringConvertible{
    case successParam
    
    var description: String{
        switch self {
        case.successParam: return "What is the success looks like?"
        }
    }
}

//Learning Resources
enum LearningResourcesSect: Int, CaseIterable, CustomStringConvertible{
    case learningResources
    
    var description: String{
        switch self {
        case.learningResources: return "Learning Resources"
        }
    }
}

//SetDate
enum SetDateSect: Int, CaseIterable, CustomStringConvertible{
    case startDate
    case endDate
    
    var description: String{
        switch self {
        case.startDate: return "Start Date"
        case.endDate: return "End Date"
        }
    }
}
