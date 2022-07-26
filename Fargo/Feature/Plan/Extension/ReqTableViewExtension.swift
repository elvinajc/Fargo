//
//  ReqTableViewExtension.swift
//  Fargo
//
//  Created by Elvina Jacia on 23/07/22.
//

import CoreData
import UIKit

extension PlanVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        //cell view height + dikit buat spacing (60 + 2)
        return 62
    }
    
    func tableView(_ tableView: UITableView, willBeginEditingRowAt indexPath: IndexPath) {
        //Set Trailing Swipe Action Height
           if let cell = tableView.cellForRow(at: indexPath) as? RequirementCell{
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
        // Selected Req
        let req = self.requirements[indexPath.row]
        editPlaceHD = req.requirementTitle!
        
        //Component of Edit Action
        let edit = UIContextualAction(style: .normal, title: "Edit") { [weak self] (action, view, completionHandler) in
            //Munculin alert edit
            //self!.loadEditAlert()
            let alertController = UIAlertController(title: "Edit Requirement Title", message: "Change the requirement title", preferredStyle: .alert)
            alertController.addTextField { (textField : UITextField!) -> Void in
                
                //MARK: -- Text Placeholder ambil dari core data (requirement title).
                textField.text = self?.editPlaceHD
                
            }
        
            //Change alert button color:
            UIView.appearance(whenContainedInInstancesOf: [UIAlertController.self]).tintColor = UIColor.darkChoco
            
        
            //Save & delete action
            let saveAction = UIAlertAction(title: "Save", style: .default, handler: { alert -> Void in
                let title = alertController.textFields![0] as UITextField
               
                //MARK: --SAVE EDIT REQUIREMENT TITLE TO CORE DATA
                print("Requirement Title Change To: \(title.text!)")
                
                let entity = NSEntityDescription.entity(forEntityName: "Requirement", in: self!.context)
                
                // Save & change req data
                req.requirementTitle = title.text
                
                do {
                    try self!.context.save()
                    
                    DispatchQueue.main.async {
                        self!.reqTableView.reloadData()
                        
                        if self!.requirements.isEmpty {
                            self!.noRequirementLabel.isHidden = false
                        } else {
                            self!.noRequirementLabel.isHidden = true
                        }
                    }
                    
                } catch {
                    print(error)
                }
                
            })
            
        
            let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: { (action : UIAlertAction!) -> Void in })

            alertController.addAction(cancelAction)
            alertController.addAction(saveAction)
        
            //Bikin save button lebih di bold
            alertController.preferredAction = saveAction
        
            self!.present(alertController, animated: true, completion: nil)
            
            completionHandler(true)
            
        }
        edit.backgroundColor = UIColor.lilDarkGray
        
        //Component of Delete Action
        let delete = UIContextualAction(style: .normal, title: "Delete") { [weak self] (action, view, completionHandler) in
            //MARK: -- REMOVE DATA REQUIREMENT BESERTA DENGAN ACTION PLANNYA DARI CORE DATA & ARRAY
//            self?.deleteData(requeTitle: self!.requirements[indexPath.row].requirementTitle!)
//            self?.requirements.remove(at: indexPath.row)
            
            let reqToRemove = self?.requirements[indexPath.row]
            self?.context.delete(reqToRemove!)
           
            do {
                try self!.context.save()
                
            } catch {
                print(error)
            }
            
            //Refetch data
            do{
                self?.requirements = try self!.context.fetch(Requirement.fetchRequest())
                    DispatchQueue.main.async {
                        self!.reqTableView.reloadData()

                        if self!.requirements.isEmpty {
                           self!.noRequirementLabel.isHidden = false
                        } else {
                            self!.noRequirementLabel.isHidden = true
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
            //MARK: --KALAU ROWNYA DI SELECT, DIA AKAN MASUK KE HALAMAN ACTION PLAN
            //Buat ngetes masuk ke halaman action plan:
        self.performSegue(withIdentifier: "goToActionPlan", sender: requirements[indexPath.row])
    }
    
    
}

extension PlanVC: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //MARK: -- Harusnya return array of data requirement.count
        //Sementara return 1 dlu buat coba
        return requirements.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "reqCell", for : indexPath) as? RequirementCell{
        //MARK: -- Harusnya cell.reqTitle.text = self."namaArray"[indexPath.row]
            //Sementara isi asal dulu:
        //    cell.reqTitle.text = "ABCDEFG"
            cell.selectionStyle = .none
            cell.layer.cornerRadius = 8
            cell.reqCellView.layer.cornerRadius = 8
            
            let thisReq = self.requirements[indexPath.row]
            print("THIS REQUIREMENT INCLUDE : \(requirements.count)")
            cell.reqTitle.text = thisReq.requirementTitle

            return cell
        }

        return UITableViewCell()
    }
    
    
    
}
