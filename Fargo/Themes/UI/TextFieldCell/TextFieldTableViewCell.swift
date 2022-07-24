//
//  TextFieldTableViewCell.swift
//  Fargo
//
//  Created by Elvina Jacia on 24/07/22.
//

import UIKit

class TextFieldTableViewCell: UITableViewCell {
    
    @IBOutlet weak var textFieldField: UITextField!
    
        
        override func awakeFromNib() {
            super.awakeFromNib()
            
            textFieldField.addDoneButtonOnKeyboard()
            textFieldField.delegate = self
        }
        
        func setTextFieldText(text: String) {
            textFieldField.text = text
        }
        
        func setHint(text: String) {
            textFieldField.placeholder = text
        }
        
        func setEnable(isEnable: Bool) {
            textFieldField.isEnabled = isEnable
            if isEnable {
                textFieldField.textColor = UIColor.black
            }else {
                textFieldField.textColor = UIColor.systemGray
            }
        }
    }

    extension TextFieldTableViewCell: UITextFieldDelegate {
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            textFieldField.resignFirstResponder()
        }
    }
