//
//  UITextViewExt.swift
//  Fargo
//
//  Created by Elvina Jacia on 21/07/22.
//

import Foundation
import UIKit

extension UITextView{

      func addDoneButtonOnKeyboard(){
          let doneTVToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
          doneTVToolbar.barStyle = .default
          
          let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
          let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneButtonAction))
          done.tintColor = UIColor.darkGreen
          let items = [flexSpace, done]
          doneTVToolbar.items = items
          doneTVToolbar.sizeToFit()
          
          self.inputAccessoryView = doneTVToolbar
      }
      
     @objc func doneButtonAction() {
          self.resignFirstResponder()
     }
    
    
}
