//
//  ActionPlanDetailModel.swift
//  Fargo
//
//  Created by Elvina Jacia on 24/07/22.
//

//Section Title
enum CellSectionTitle: Int, CaseIterable,CustomStringConvertible{
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

