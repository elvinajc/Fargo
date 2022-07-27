//
//  ActionCell.swift
//  Fargo
//
//  Created by Elvina Jacia on 23/07/22.
//

import UIKit
import CoreData

class ActionCell: UITableViewCell {
    
    //Properties
    @IBOutlet weak var actCellView: UIView!
    @IBOutlet weak var checkmarkButton: UIButton!
    @IBOutlet weak var actNameLbl: UILabel!
    @IBOutlet weak var actDateLbl: UILabel!
    
    //ImageIcon
     let uncheckIcon = UIImage(systemName: "square")
     let checkIcon = UIImage(systemName: "checkmark.square.fill")
    
     var actionStatus = ""
    
    //Core Data Properties
    var actionplans = [ActionPlan]()
    var firstLoad = true
    let context  = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        fetchStatus()
    
      
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //Func
    @IBAction func checkmarkBtnAction(_ sender: UIButton) {
        
        //Ganti button colornya : button.backgroundColor = UIColor.blue
        //Ganti button sesuai kalo dipencet : checkmarkButton.setImage(image, forState: .normal)
        //Update progress
        
      
            //checkmarkButton.isSelected = false
        
        if checkmarkButton.currentImage == uncheckIcon{
            checkmarkButton.setImage(checkIcon, for: .normal)
            checkmarkButton.tintColor = .darkChoco
            checkmarkButton.isSelected = true
            actionStatus = "Done"
            
            updateCheckmarkStatus()
            print("CHECKMARK Done")
            
        } else {
            checkmarkButton.setImage(uncheckIcon, for: .normal)
            checkmarkButton.tintColor = .softGray
            checkmarkButton.isSelected = true
            actionStatus = "Undone"
            
            updateCheckmarkStatus()
            print("CHECKMARK Undone")
        }
        
    }
    
    func updateCheckmarkStatus(){
    
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "ActionPlan")
        do {
            let results: NSArray = try context.fetch(request) as NSArray
            for result in results{
                let actPlan = result as! ActionPlan
                actPlan.status = actionStatus
                    
                    try context.save()

                    }
        } catch  {
                print("Fetch failed")
            }
    }

    
    func fetchStatus(){
        //Fetech statusnya
        let request = NSFetchRequest<NSFetchRequestResult> (entityName: "ActionPlan")
        
        do{
            
            let results : NSArray = try context.fetch(request) as NSArray
            let pred = NSPredicate(format: "status == %@", "Undone")
            request.predicate = pred
            
            for result in results {
                let act = result as! ActionPlan
                
                //let actStatus = (result as AnyObject).value(forKey: "status") as? String
                actionplans.append(act)
                
                if act.status == "Done"{
                    checkmarkButton.setImage(checkIcon, for: .normal)
                    checkmarkButton.tintColor = .darkChoco
                    checkmarkButton.isSelected = true
                } else{
                    checkmarkButton.setImage(uncheckIcon, for: .normal)
                    checkmarkButton.tintColor = .softGray
                    checkmarkButton.isSelected = false
                }

            }
        }catch{
            print(error)
        }
    }
    
    func saveStatus(){
        
    }
    
    
    
    
}
