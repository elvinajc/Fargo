//
//  TextViewTableViewCell.swift
//  Fargo
//
//  Created by Elvina Jacia on 24/07/22.
//

import UIKit

class TextViewTableViewCell: UITableViewCell {

    @IBOutlet weak var textViewField: UITextView!
        
        var placeholder = "Placeholder"
        
        override func awakeFromNib() {
            super.awakeFromNib()
            
            textViewField.layer.cornerRadius = 8
            textViewField.addDoneButtonOnKeyboard()
            textViewField.delegate = self
        }
        
        func setPlaceholder(text: String) {
            placeholder = " \(text)"
            textViewField.text = placeholder
            textViewField.textColor = UIColor.softGray
        }
        
        func setTextView(text: String) {
            textViewField.text = text
            textViewField.textColor = UIColor.black
        }
        
        func setEnable(isEnable: Bool) {
            textViewField.isEditable = isEnable
            if isEnable {
                textViewField.textColor = UIColor.black
            }else {
                textViewField.textColor = UIColor.softGray
            }
        }
     
    }

    extension TextViewTableViewCell: UITextViewDelegate {
        func textViewDidBeginEditing(_ textView: UITextView) {
            if (textViewField.text == placeholder)
            {
                textViewField.text = nil
                textViewField.textColor = UIColor.black
            }
        }

        func textViewDidEndEditing(_ textView: UITextView) {
            if textViewField.text.isEmpty
            {
                textViewField.text = placeholder
                textViewField.textColor = UIColor.systemGray3
            }
            textViewField.resignFirstResponder()
        }
    }
