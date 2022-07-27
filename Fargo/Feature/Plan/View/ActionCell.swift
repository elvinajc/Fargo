//
//  ActionCell.swift
//  Fargo
//
//  Created by Elvina Jacia on 23/07/22.
//

import UIKit
import CoreData

protocol receiveStatus{
    func buttonTap(status: String)
}

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

    var delegate: receiveStatus?
    var delegates: updateProgressLabel?
    
    var countDone : Int = 0
    
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
        
        //Ganti button colornya : button.backgroundColor = UIColor.blue
        //Ganti button sesuai kalo dipencet : checkmarkButton.setImage(image, forState: .normal)
        //Update progress
        
    
            if checkmarkButton.currentImage == uncheckIcon{
                checkmarkButton.setImage(checkIcon, for: .normal)
                checkmarkButton.tintColor = .darkChoco
                checkmarkButton.isSelected = true
                actionStatus = "Done"
                delegate?.buttonTap(status: "Done")
                
                countDone += 1
                
                delegates?.buttonClicked(numOfDone: countDone)
                
                //updateCheckmarkStatus()
                print("CHECKMARK Done")
                
            } else {
                checkmarkButton.setImage(uncheckIcon, for: .normal)
                checkmarkButton.tintColor = .softGray
                checkmarkButton.isSelected = false
                actionStatus = "Undone"
                delegate?.buttonTap(status: "Undone")
                
                countDone -= 1
                
                //Supaya value countDone ga dibawah 0
                if countDone < 0{
                    countDone = 0
                }
                
                delegates?.buttonClicked(numOfDone: countDone)
                
                
               // updateCheckmarkStatus()
                print("CHECKMARK Undone")
            }
        
    }
    
    

    
    
}
