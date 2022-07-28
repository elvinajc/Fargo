//
//  TextViewExtension.swift
//  Fargo
//
//  Created by Elvina Jacia on 20/07/22.
//

import UIKit


extension GoalSettingVC: UITextViewDelegate{

    func textViewDidChangeSelection(_ textView: UITextView) {
        if self.view.window != nil {
            if textView.textColor == UIColor.lightGray {
                textView.selectedTextRange = textView.textRange(from: textView.beginningOfDocument, to: textView.beginningOfDocument)
            }
        }
    }
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        var currentFirstResponder: UITextView?

        if textView.tag == 1{
            currentFirstResponder = goalField
        } else if textView.tag == 2{
            print(currentFirstResponder)
            currentFirstResponder = reasonField
        }

        return true
    }

    //  Func delegate ketika text view idea desc diedit
    func textViewDidBeginEditing(_ textView: UITextView) {
        print(textView.tag)
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
            case 1 :    if goalField.text == "\n"{
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
                                 goalField.textColor = UIColor.softGray
                            
                  case 2 :      reasonField.text = "e.g. I want to get a new experience, get many connections, get big salary to buy a new house"
                                reasonField.textColor = UIColor.softGray
                          
                  default: ""
              }
        }
      }


    
}
