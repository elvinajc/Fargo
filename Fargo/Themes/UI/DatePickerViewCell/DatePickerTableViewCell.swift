//
//  DatePickerTableViewCell.swift
//  Fargo
//
//  Created by Elvina Jacia on 24/07/22.
//

import UIKit

class DatePickerTableViewCell: UITableViewCell {

    @IBOutlet weak var dateView: UIView!
 
    @IBOutlet weak var dateField: UITextField!
    
  
    
    let pickerView = UIDatePicker()

    var selectRow : Int = 0

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        dateField.textColor = .darkChoco
        dateField.layer.borderWidth = 0
        dateField.inputView = pickerView
        

    }

 
    
    
}
