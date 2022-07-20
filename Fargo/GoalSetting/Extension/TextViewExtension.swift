//
//  TextViewExtension.swift
//  Fargo
//
//  Created by Elvina Jacia on 20/07/22.
//

import UIKit

var isSelected : Bool = false

extension GoalSettingVC: UITextViewDelegate{
    func textViewDidChangeSelection(_ textView: UITextView) {
        if self.view.window != nil {
            if textView.textColor == UIColor.lightGray {
                textView.selectedTextRange = textView.textRange(from: textView.beginningOfDocument, to: textView.beginningOfDocument)
            }
        }
    }
    //  Func delegate ketika text view idea desc diedit
    func textViewDidBeginEditing(_ textView: UITextView) {
        switch textView.tag {
            case 1 :
                        goalField.text = ""
                        goalField.textColor = UIColor.black
                        print(1)
                        return
            
            case 2 :    reasonField.text = ""
                        reasonField.textColor = UIColor.black
                        print(2)
                        return
            default:
                return
        }
        
    }

      
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        switch textView.tag {
            case 1 :     if goalField.text == "\n"{
                        goalField.resignFirstResponder()
                        }
            case 2 :   if reasonField.text == "\n"{
                        reasonField.resignFirstResponder()
                        }
            default: ""
        }
          return true
      }
      
      func textViewDidEndEditing(_ textView: UITextView) {
          if textView.text == "" {
            
              switch textView.tag {
                  case 1 :       goalField.text = "e.g. I want to be an iOS Developer at ABCDX company"
                                 goalField.textColor = UIColor.gray
                              //   goalField.returnKeyType = .done
                  case 2 :     reasonField.text = "e.g. I want to get a new experience, get many connections, get big salary to buy a new house"
                  reasonField.textColor = UIColor.softGray
                  //  goalField.returnKeyType = .done
                  default:
                     ""
              }
              
          
          }
      }
    
}
