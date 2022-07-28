//
//  ActTableViewExtension.swift
//  Fargo
//
//  Created by Elvina Jacia on 23/07/22.
//

import CoreData
import UIKit


extension ActionPlanVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        //cell view height + dikit buat spacing (60 + 2)
        return 62
    }
    
    func tableView(_ tableView: UITableView, willBeginEditingRowAt indexPath: IndexPath) {
        //Set Trailing Swipe Action Height
           if let cell = tableView.cellForRow(at: indexPath) as? ActionCell{
               if let trailingCell = cell.superview{
                   for trailingSwipe in trailingCell.subviews{
                       let typeview = type(of: trailingSwipe.self)
                       if typeview.description() == "UISwipeActionPullView"{
                           trailingSwipe.frame.size.height = 60//size of swipe action
                           trailingSwipe.frame.origin.y = 0 //start position of y
                       }
                   }
               }
           }
       }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        //Component of Delete Action
        let delete = UIContextualAction(style: .normal, title: "Delete") { [weak self] (action, view, completionHandler) in
            //MARK: -- REMOVE DATA  ACTION PLANNYA DARI CORE DATA & ARRAY
    
            //DELETE DATA
            print("Index \(indexPath.row)")
            print("Action \(self!.actionplans.count)")
            let actToRemove = self?.actionplans[indexPath.row]
            
            self?.context.delete(actToRemove!)
            
            do {
                try self!.context.save()
                
            } catch {
                print(error)
            }

                self!.fetchActionPlanData()
        
            completionHandler(true)
        }
        delete.backgroundColor = UIColor.redTomato
    
        //Masukin Edit & Delete ke Trailing Actionnya
        let configuration = UISwipeActionsConfiguration(actions: [delete]) //, edit])
        configuration.performsFirstActionWithFullSwipe = false
        
        return configuration
    }
    ///////
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            //MARK: -KALAU ROWNYA DI SELECT, DIA AKAN MASUK KE HALAMAN ACTION PLAN DETAIL UTK EDIT
            self.performSegue(withIdentifier: "goToEditActionPlan", sender: self)
            print("Masuk ke Action Details untuk edit")
      
    }
    
    
}

extension ActionPlanVC: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return actionplans.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "actCell", for : indexPath) as? ActionCell{
            cell.selectionStyle = .none
            cell.layer.cornerRadius = 8
            cell.actCellView.layer.cornerRadius = 8
            
            let thisAct = self.actionplans[indexPath.row]
            print("THIS ACTION PLANS INCLUDE : \(actionplans.count)")
            print("THIS ROW IS \(indexPath.row)")
            cell.actNameLbl.text = thisAct.actionName
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "d MMM"
            let edate = dateFormatter.string(from: thisAct.endDate!)
            cell.actDateLbl.text = edate
            cell.checkmarkButton.tag = indexPath.row
         
        
            if thisAct.status == "Done"{
                cell.checkmarkButton.setImage(cell.checkIcon, for: .normal)
                cell.checkmarkButton.tintColor = .darkChoco
                cell.checkmarkButton.isSelected = true
            } else{
                cell.checkmarkButton.setImage(cell.uncheckIcon, for: .normal)
                cell.checkmarkButton.tintColor = .softGray
                cell.checkmarkButton.isSelected = false
            }

            cell.delegates = self

            return cell
        }

        return UITableViewCell()
    }
    
    
    
}
