//
//  ActTableViewExtension.swift
//  Fargo
//
//  Created by Elvina Jacia on 23/07/22.
//


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
        
        //Component of Edit Action
        let edit = UIContextualAction(style: .normal, title: "Edit") { [weak self] (action, view, completionHandler) in
            //MARK: -- Segue ke halaman action detail utk edit dan munculin datanya sesuai row tsb
            self?.performSegue(withIdentifier: "goToEditActionPlan", sender: self)
            print("Masuk ke Action Details untuk Edit")
            
            
            completionHandler(true)
            
        }
        edit.backgroundColor = UIColor.lilDarkGray
        
        //Component of Delete Action
        let delete = UIContextualAction(style: .normal, title: "Delete") { [weak self] (action, view, completionHandler) in
            //MARK: -- REMOVE DATA  ACTION PLANNYA DARI CORE DATA & ARRAY
    
            //DELETE DATA
            let actToRemove = self?.actionplans[indexPath.row]
            self?.context.delete(actToRemove!)
           
            do {
                try self!.context.save()
                
            } catch {
                print(error)
            }
            
            //Refetch data
            do{
                self?.actionplans = try self!.context.fetch(ActionPlan.fetchRequest())
                    DispatchQueue.main.async {
                        self!.actTableView.reloadData()

                        if self!.actionplans.isEmpty {
                           self!.noActPlanLabel.isHidden = false
                        } else {
                            self!.noActPlanLabel.isHidden = true
                        }
                    }
            } catch {
                print(error)
            }

            completionHandler(true)
        }
        delete.backgroundColor = UIColor.redTomato
        
        
        //Masukin Edit & Delete ke Trailing Actionnya
        let configuration = UISwipeActionsConfiguration(actions: [delete, edit])
        configuration.performsFirstActionWithFullSwipe = false
        
        return configuration
    }
    ///////
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            //MARK: -KALAU ROWNYA DI SELECT, DIA AKAN MASUK KE HALAMAN ACTION PLAN DETAIL UTK EDIT
            //MUNCULIN DATA SESUAI ROW YG DI SELECT
            self.performSegue(withIdentifier: "goToEditActionPlan", sender: self)
            print("Masuk ke Action Details untuk edit")
      
    }
    
    
}

extension ActionPlanVC: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //MARK: -- Harusnya return array of data actionplans.count
        //Sementara return 1 dlu buat coba
        return actionplans.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "actCell", for : indexPath) as? ActionCell{
        //MARK: -- Harusnya cell.actNameLabel.text = self."namaArray"[indexPath.row]
            //Sementara isi asal dulu:
        //    cell.actTitle.text = "ABCDEFG"
            cell.selectionStyle = .none
            cell.layer.cornerRadius = 8
            cell.actCellView.layer.cornerRadius = 8
            
            let thisAct = self.actionplans[indexPath.row]
            print("THIS ACTION PLANS INCLUDE : \(actionplans.count)")
            cell.actNameLbl.text = thisAct.actionName
            return cell
        }

        return UITableViewCell()
    }
    
    
    
}
