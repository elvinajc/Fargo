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

    var delegates: updateProgressLabel?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
      
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //Func
    @IBAction func checkmarkBtnAction(_ sender: UIButton) {
        
        print("TAGNYA" , sender.tag)
    
            if checkmarkButton.currentImage == uncheckIcon{
                checkmarkButton.setImage(checkIcon, for: .normal)
                checkmarkButton.tintColor = .darkChoco
                checkmarkButton.isSelected = true
                actionStatus = "Done"
                delegates?.buttonClicked(status: "Done", numOfDone: 1, buttonRow: sender.tag)
                //print("CHECKMARK Done")
                
            } else {
                checkmarkButton.setImage(uncheckIcon, for: .normal)
                checkmarkButton.tintColor = .softGray
                checkmarkButton.isSelected = false
                actionStatus = "Undone"
                delegates?.buttonClicked(status: "Undone", numOfDone: -1, buttonRow : sender.tag)
               // print("CHECKMARK Undone")
            }
        
    }
    
    

    
    
}
