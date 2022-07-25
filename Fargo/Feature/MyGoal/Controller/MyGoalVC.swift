//
//  MyGoalVC.swift
//  Fargo
//
//  Created by Elvina Jacia on 21/07/22.
//

import UIKit
import CoreData


class MyGoalVC: UIViewController{

    
    //Properties
    @IBOutlet weak var progressView: UIView!
    @IBOutlet weak var circleProgressView: UIView!
    
    @IBOutlet weak var progressPercentNumLabel: UILabel!

    @IBOutlet weak var editGoalBtn: UIButton!
    
    @IBOutlet weak var goalLabel: UILabel!
    @IBOutlet weak var reasonLabel: UILabel!
    
    @IBOutlet weak var detailView: UIView!

   //MARK: -- CORE DATA
    var goalss = [Goal]()
    var actionPlan = [ActionPlan]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configureMyGoalUI()
        getGoalData()
    
        
    }
    
    
    //MARK: -- FUNC Configure UI
    func configureMyGoalUI(){
        setProgressView()
        setRoundLabel()
        setRoundedView()
    }
    
    func setProgressView(){
        //Set progress view to rounded corner
        progressView.layer.cornerRadius = 20
        
        //Set circle progress bar
        
        
        //Set percentLabel
        //get percent data dari core data

    }
    
    func setRoundLabel(){
        //Set border of label become rounded
        goalLabel.layer.masksToBounds = true
        goalLabel.layer.cornerRadius = 20
        reasonLabel.layer.masksToBounds = true
        reasonLabel.layer.cornerRadius = 20
        
        goalLabel.textColor = .white
        goalLabel.font = UIFont.boldSystemFont(ofSize: 17.0)

         reasonLabel.textColor = .white
         reasonLabel.font = UIFont.boldSystemFont(ofSize: 16.0)
    }
    
    func setRoundedView(){
        detailView.clipsToBounds = true
        detailView.layer.cornerRadius = 20
        // Round Top right corner, Top left corner 
        detailView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
    }
    
    //MARK: -- FUNC BUTTON ACTION
    @IBAction func editBtnAction(_ sender: UIButton) {
        self.performSegue(withIdentifier: "goToGoalSetting", sender: self)
    }
    
    //MARK: -- FUNC GET DATA FROM CORE DATA
    func getGoalData(){
       //Ambil data goal dari core data & tampilkan ke label yg ada
        print("GET GOAL DATA")
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        let requests = NSFetchRequest<NSFetchRequestResult> (entityName: "Goal")
        
        do{
            let results : NSArray = try context.fetch(requests) as NSArray
            for result in results {
                if let goal = (result as AnyObject).value(forKey: "goalDesc") as? String {
                    goalLabel.text = goal
                }
                if let reason = (result as AnyObject).value(forKey: "reason") as? String {
                    reasonLabel.text = reason
                }
            }
        }catch{
            print(error)
        }
        
    }
    
    //MARK: FETCH DATA DARI CORE DATA, COUNT JUMLAH DATA YG STATUSNYA COMPLETE & SET CIRCLE PROGRESS BAR
    func getActionData(){
        //Count jumlah task yg statusnya "complete",
    }

    
}

