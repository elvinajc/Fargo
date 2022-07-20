//
//  GoalSettingVC.swift
//  Fargo
//
//  Created by Elvina Jacia on 20/07/22.
//


import UIKit

class GoalSettingVC: UIViewController {

    //Properties
 
    @IBOutlet weak var goalQuestLabel: UILabel!
    
    @IBOutlet weak var goalField: UITextView!
    
    @IBOutlet weak var reasonLabel: UILabel!
    
    @IBOutlet weak var reasonField: UITextView!
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configureUI()
       
        goalField.delegate = self
    }

    //Function
    func configureUI(){
        confNavBar()
        confTextView()
        
    }
    
    func confNavBar(){
        let doneBtn = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: self, action: #selector(done))
        navigationItem.rightBarButtonItem = doneBtn
        doneBtn.tintColor = .darkGreen
    }

    @objc func done() {
        //SAVE GOAL & REASON KE CORE DATA
        print("doness")
        
        //perform segue
        self.performSegue(withIdentifier: "goToTabBar", sender: self)
        
    }
    
    func confTextView(){
        goalField.tag = 1
        goalField.layer.cornerRadius = 8
        goalField.text =  "e.g. I want to be an iOS Developer at ABCDX company"
        goalField.textColor = .softGray
        goalField.returnKeyType = .done
        
        reasonField.tag = 2
        reasonField.layer.cornerRadius = 8
        reasonField.text = "e.g. I want to get a new experience, get many connections, get big salary to buy a new house"
        goalField.textColor = .softGray
        goalField.returnKeyType = .done
        
    }
    

}
