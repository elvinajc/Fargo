//
//  ActDetailTableViewExtension.swift
//  Fargo
//
//  Created by Elvina Jacia on 24/07/22.
//

import UIKit

extension ActionPlanDetailVC : UITableViewDelegate {
    
}


extension ActionPlanDetailVC : UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
       return ActPlanDetailCellSection.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = ActPlanDetailCellSection(rawValue: section) else { return 0 }
        switch section {
            case .actionNameTl       : return ActionNameSect.allCases.count
            case .actionDescTl       : return ActionDescSect.allCases.count
            case .successParameterTl : return SuccessParamSect.allCases.count
            case .learningResourceTl : return LearningResourcesSect.allCases.count
            case .setDateTl          : return SetDateSect.allCases.count
            default                  : return 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .clear
        
        //Set Section Title
        let title = UILabel()
        title.font = UIFont.boldSystemFont(ofSize: 17)
        title.textColor = .darkGreen
        title.text = ActPlanDetailCellSection(rawValue: section)?.description
        
        view.addSubview(title)
        
        title.translatesAutoresizingMaskIntoConstraints = false
        title.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        title.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let section = ActPlanDetailCellSection(rawValue: indexPath.section) else { return UITableViewCell() }
 
        switch section {
            case .actionNameTl       :
            let cell = tableView.dequeueReusableCell(withIdentifier: "TextFieldCell", for: indexPath) as! TextFieldTableViewCell
                 cell.backgroundColor = .clear
                 cell.layer.cornerRadius = 8
                 cell.selectionStyle = .none
              
            return cell
            
            case .actionDescTl       :
                let cell = tableView.dequeueReusableCell(withIdentifier: "TextViewCell", for: indexPath) as! TextViewTableViewCell
                cell.backgroundColor = .clear
                cell.layer.cornerRadius = 8
                cell.selectionStyle = .none
                    
                return cell
            
            case .successParameterTl :
                let cell = tableView.dequeueReusableCell(withIdentifier: "TextViewCell", for: indexPath)as! TextViewTableViewCell
                cell.backgroundColor = .clear
                cell.layer.cornerRadius = 8
                cell.selectionStyle = .none
                
                return cell
            
            case .learningResourceTl :
                let cell = tableView.dequeueReusableCell(withIdentifier: "TextViewCell", for: indexPath)as! TextViewTableViewCell
                cell.backgroundColor = .clear
                cell.layer.cornerRadius = 8
                cell.selectionStyle = .none
            
                return cell
            
            case .setDateTl          :
                //MARK: -- MASIH BELOM DIGANTI
               
               guard let sections = SetDateSect(rawValue: indexPath.row) else { return UITableViewCell() }
            
                switch sections{
                    
                    case .startDate :
                    // let cell = tableView.dequeueReusableCell(withIdentifier: DatePickerTableViewCell.identifier, for: indexPath)
                      let cell = tableView.dequeueReusableCell(withIdentifier: "Test", for: indexPath)
                      //cell.backgroundColor = .clear
                      cell.layer.cornerRadius = 8
                      cell.selectionStyle = .none
                      
                      return cell
                    
                    case .endDate :
                    // let cell = tableView.dequeueReusableCell(withIdentifier: DatePickerTableViewCell.identifier, for: indexPath)
                     let cell = tableView.dequeueReusableCell(withIdentifier: "Test", for: indexPath)
                     //cell.backgroundColor = .clear
                     cell.layer.cornerRadius = 8
                     cell.selectionStyle = .none
                    
                    return cell
                
                    default:
                     ""
                }
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
     
        guard let section = ActPlanDetailCellSection(rawValue: indexPath.section) else { return 0 }
        switch section {
            case .actionNameTl       : return 44
            case .actionDescTl       : return 105
            case .successParameterTl : return 105
            case .learningResourceTl : return 105
            case .setDateTl          : return 44
            default                  : return 0
        }
        
    }
    
    
}
