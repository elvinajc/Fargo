//
//  GoalSettingVC.swift
//  Fargo
//
//  Created by Elvina Jacia on 20/07/22.
//

import CoreData
import UIKit

class GoalSettingVC: UIViewController {

    //Properties 
    @IBOutlet weak var goalQuestLabel: UILabel!
    @IBOutlet weak var goalField: UITextView!
    @IBOutlet weak var reasonLabel: UILabel!
    @IBOutlet weak var reasonField: UITextView!
    
    //MARK: CORE DATA 
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var goals: [Goal] = [Goal]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
     
        configureUI()
       
    }

    override func viewWillAppear(_ animated: Bool) {
      //   checkTheGoal()
    }
    
    //Function
    func configureUI(){
        confNavBar()
        confTextView()
        addGestureRecDismissKeyboard()
    }
    
    func confNavBar(){
       
        let doneBtn = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: self, action: #selector(done))
        navigationItem.rightBarButtonItem = doneBtn
        doneBtn.tintColor = .darkChoco
    }

    @objc func done() {
        //MARK: -- SAVE GOAL & REASON KE CORE DATA
        print("Done Set The Goals")
        
        print("Goal  : \(goalField.text!)")
        print("Reason: \(reasonField.text!)")
        
        saveGoalReason()
        
        //perform segue
        self.performSegue(withIdentifier: "goToTabBar", sender: self)
        
    }
    
    func confTextView(){
        goalField.tag = 1
        goalField.layer.cornerRadius = 8
        goalField.text =  "e.g. I want to be an iOS Developer at ABCDX company"
        goalField.textColor = .softGray
   
        
        reasonField.tag = 2
        reasonField.layer.cornerRadius = 8
        reasonField.text = "e.g. I want to get a new experience, get many connections, get high salary to buy a new house"
        reasonField.textColor = .softGray
        
        //textfield delegate
        goalField.delegate = self
        reasonField.delegate = self
       
        //add done button to keyboard (goalfield & reasonfield)
        goalField.addDoneButtonOnKeyboard()
        reasonField.addDoneButtonOnKeyboard()
        
    }
    
    func addGestureRecDismissKeyboard(){
        //Looks for single or multiple taps.
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))

        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
        //tap.cancelsTouchesInView = false

        view.addGestureRecognizer(tap)
    }
    
    
    //Calls this function when the tap is recognized.
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    //MARK: CORE DATA FUNCT
 
    
    func saveGoalReason(){
        // Create a goal obj
        let newGoal = Goal(context: self.context)
        newGoal.goalDesc = goalField.text
        newGoal.reason = reasonField.text
     
        // Save goal data
        do {
            try self.context.save()
        } catch {
            print(error)
        }
    
    }

}
