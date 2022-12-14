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
    var goals = [Goal]()
    var firstLoad = true
    let context  = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        if firstLoad {
            firstLoad = false
            fetchGoalData()
        }
        configureUI()
    
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
//        print("Done Set The Goals")
//
//        print("Goal  : \(goalField.text!)")
//        print("Reason: \(reasonField.text!)")
    
        saveGoalReason()
        
    }
    
    func confTextView(){
        goalField.tag = 1
        goalField.layer.cornerRadius = 8
        reasonField.tag = 2
        reasonField.layer.cornerRadius = 8
        
        if goalField.text.isEmpty {
            goalField.text =  "e.g. I want to be an iOS Developer at ABCDX company"
            goalField.textColor = .softGray
        } else {
            goalField.textColor = .black
        }
        
        if reasonField.text.isEmpty {
            reasonField.text = "e.g. I want to get a new experience, get many connections, get high salary to buy a new house"
            reasonField.textColor = .softGray
        } else{
            goalField.textColor = .black
        }
       
        
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
        view.addGestureRecognizer(tap)
    }
    
    
    //Calls this function when the tap is recognized.
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text views) to resign the first responder status.
        view.endEditing(true)
    }
    
    //MARK: CORE DATA FUNCT

    func saveGoalReason(){
      
        let entity = NSEntityDescription.entity(forEntityName: "Goal", in: context)
      
        if goals.isEmpty{
            // Create a goal obj
            let newGoal = Goal(entity: entity!, insertInto: context)
            newGoal.setValue(self.goalField.text, forKey: "goalDesc")
            newGoal.setValue(self.reasonField.text, forKey: "reason")
            
            // Save goal data
            do {
                try context.save()
                //Tambahin ke arraylist
                goals.append(newGoal)
                
                //perform segue
                self.performSegue(withIdentifier: "goToTabBar", sender: self)
                
            } catch {
                print(error)
            }
        }else{
            // Save & change req data
            let goal = Goal()
            goal.setValue(self.goalField.text, forKey: "goalDesc")
            goal.setValue(self.reasonField.text, forKey: "reason")
            
            do {
                try self.context.save()
                
            } catch {
                print(error)
            }
        }
        
//        print("GOALSNYA ADA : \(goals.count)")

    }

    func fetchGoalData(){
        let request = NSFetchRequest<NSFetchRequestResult> (entityName: "Goal")
        
        do{
            let results : NSArray = try context.fetch(request) as NSArray
            for result in results {
                if let goal = (result as AnyObject).value(forKey: "goalDesc") as? String {
                    goalField.text = goal
                }
                if let reason = (result as AnyObject).value(forKey: "reason") as? String {
                    reasonField.text = reason
                }
            }
        }catch{
            print(error)
        }

    }
    

}
