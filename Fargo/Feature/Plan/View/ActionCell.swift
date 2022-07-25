//
//  ActionCell.swift
//  Fargo
//
//  Created by Elvina Jacia on 23/07/22.
//

import UIKit

class ActionCell: UITableViewCell {
    
    //Properties
    @IBOutlet weak var actCellView: UIView!
    @IBOutlet weak var checkmarkButton: UIButton!
    @IBOutlet weak var actNameLbl: UILabel!
    @IBOutlet weak var actDateLbl: UILabel!
    
    //ImageIcon
     let uncheckIcon = UIImage(systemName: "square")
     let checkIcon = UIImage(systemName: "checkmark.square.fill")
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
         checkmarkButton.tintColor = .softGray
//        if checkmarkButton.currentImage == uncheckIcon{
//            //checkmarkButton.tintColor = .softGray
//            checkmarkButton.backgroundColor = .clear
//        } else {
//            checkmarkButton.tintColor = .darkChoco
//        }
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
            checkmarkButton.setImage(checkIcon, for: .normal)
            checkmarkButton.tintColor = .darkChoco
       
            checkmarkButton.isSelected = true
    
        
        print("CHECKMARK DIPENCET")
        
        
    }
    
}
