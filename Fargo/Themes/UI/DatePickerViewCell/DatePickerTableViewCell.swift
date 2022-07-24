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
    
    let datePicker = UIDatePicker()
    var selectRow : Int = 0

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setDoneBtn()
        setDateField()
        setDatePicker()
        
        //dateField.addDoneButtonOnKeyboard()
        
        //MARK: SET VALUE DATE PICKER SESUAI DATA YG DIAMBIL DARI CORE DATA
        //Sementara di set ke date hari ini:
        dateField.text = dateFormatting(date: Date())
       

    }

    @objc func dateChange(datePicker: UIDatePicker){
        dateField.text = dateFormatting(date: datePicker.date)
        
        //
    }
 
    
    func dateFormatting(date: Date) -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM d, yyyy"
        return formatter.string(from: date)
    }
    
    func setDoneBtn(){
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePicker))
        doneBtn.tintColor = .darkChoco
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let items = [flexibleSpace, doneBtn]
        toolBar.setItems(items, animated: true)
        
        dateField.inputAccessoryView = toolBar
    }
    
    
    func setDateField(){
        //Set DateField Appearance
        dateField.textColor = .darkChoco
        dateField.layer.borderWidth = 0
        dateField.inputView = datePicker
        
    }
    
    func setDatePicker(){
        //Set Date Picker Appearance
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.addTarget(self, action: #selector(dateChange(datePicker:)), for: UIControl.Event.valueChanged)
    }
    
    @objc func donePicker() {

        dateField.resignFirstResponder()

//        defaultFocusTime = Int(focusSelectedTxt)!*60
//     //testing valuenya keganti gak
//        print("Focus")
//        print(defaultFocusTime)

        //MARK: TAMBAHAN UTK SET STATE ROW PICKER VIEW
//        let row = datePicker.selectedRow(inComponent: 0)
//        datePicker.selectRow(row, inComponent: 0, animated: true)
//    selectRow = row
        
       // defaults.setValue(selectRow, forKey: picker)
    }
    
    
}
