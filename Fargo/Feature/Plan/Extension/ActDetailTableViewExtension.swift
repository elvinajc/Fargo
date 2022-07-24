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
    
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        <#code#>
//    }
//
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let section = ActPlanDetailCellSection(rawValue: indexPath.section) else { return UITableViewCell() }
   //     let cell  = tableView.dequeueReusableCell(withIdentifier: "Test", for: indexPath)
        
        switch section {
            case .actionNameTl       :
            let cell = tableView.dequeueReusableCell(withIdentifier: "TextFieldCell", for: indexPath) as! TextFieldTableViewCell
                //cell.textLabel?.text = SettingCellFillOpt(rawValue: 0)?.description
                 cell.backgroundColor = .clear
                 cell.layer.cornerRadius = 8
                 cell.selectionStyle = .none
                 //cell.actCellView.layer.cornerRadius = 8
            return cell
            
            case .actionDescTl       :
                let cell = tableView.dequeueReusableCell(withIdentifier: "TextViewCell", for: indexPath) as! TextViewTableViewCell
            
//                cell.selectionStyle = .none
//                cell.setEnable(isEnable: isAbleToEdit)
//                cell.setLabel(text: "Description")
//                guard let description = monster?.description else { return cell }
//                cell.setTextView(text: description)

//               default:
//                let cell = UITableViewCell()
                return cell
            
            case .successParameterTl :
                let cell = tableView.dequeueReusableCell(withIdentifier: "TextViewCell", for: indexPath)as! TextViewTableViewCell
           
                return cell
            
            case .learningResourceTl :
              let cell = tableView.dequeueReusableCell(withIdentifier: "TextViewCell", for: indexPath)as! TextViewTableViewCell
           
                return cell
            
            case .setDateTl          :
                //MARK: -- MASIH BELOM DIGANTI
               // let cell = tableView.dequeueReusableCell(withIdentifier: DatePickerTableViewCell.identifier, for: indexPath)
               guard let sections = SetDateSect(rawValue: indexPath.row) else { return UITableViewCell() }
            
                switch sections{
                    
                    case .startDate :
                      let cell = tableView.dequeueReusableCell(withIdentifier: "Test", for: indexPath)
                      return cell
                    
                    case .endDate :
                     let cell = tableView.dequeueReusableCell(withIdentifier: "Test", for: indexPath)
                     return cell
                
                    default:
                     ""
                }
            
        }
        
    }
                
            
               //cell.textLabel?.text = SettingCellFillOpt(rawValue: 0)?.description
              
               // Remove selection style
               // cell.selectionStyle = .none
            
                // cell.layer.cornerRadius = 8
                //cell.actCellView.layer.cornerRadius = 8
 
        
//        switch indexPath.section {
//            case 0 : cell.backgroundColor = .darkChoco
//            case 1 : cell.backgroundColor = .darkGray
//            case 2 : cell.backgroundColor = .lilDarkGray
//            case 3 : cell.backgroundColor = .softEmeraldGreen
//            case 4 : cell.backgroundColor = .blue
//            default: break
//        }
            

    
    
}
