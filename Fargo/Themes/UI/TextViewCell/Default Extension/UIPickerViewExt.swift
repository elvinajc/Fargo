//
//  UIPickerViewExt.swift
//  Fargo
//
//  Created by Elvina Jacia on 24/07/22.
//

import Foundation
import UIKit

extension UIPickerView{

      func addDoneButtonOnKeyboard(){
          let doneTFToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
          doneTFToolbar.barStyle = .default
          
          let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
          let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneButtonAction))
          done.tintColor = UIColor.darkGreen
          let items = [flexSpace, done]
          doneTFToolbar.items = items
          doneTFToolbar.sizeToFit()
          
      }
      
     @objc func doneButtonAction() {
         //Save state ke user default
      // defaults.setValue(selectRow, forKey: pick)
         
         print("DATE NYA KE SAVE DISINI BRO")
         
         
         self.resignFirstResponder()
         
      
     }
    

}
