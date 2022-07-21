//
//  UITextViewExt.swift
//  Fargo
//
//  Created by Elvina Jacia on 21/07/22.
//

import Foundation
import UIKit

extension UITextView{
    
//      @IBInspectable var doneAcc: Bool{
//          get{
//              return self.doneAcc
//          }
//          set (hasDone) {
//              if hasDone{
//                  addDoneButtonOnKeyboard()
//              }
//          }
//      }
//
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
    
    
//    func centerVerticalText() {
//           self.textAlignment = .center
//           let fitSize = CGSize(width: bounds.width, height: CGFloat.greatestFiniteMagnitude)
//           let size = sizeThatFits(fitSize)
//           let calculate = (bounds.size.height - size.height * zoomScale) / 2
//           let offset = max(1, calculate)
//           contentOffset.y = -offset
//    }

}
