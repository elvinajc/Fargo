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
    @IBOutlet weak var circleProgressView: CircleProgressView!
    
    @IBOutlet weak var progressPercentNumLabel: UILabel!

    @IBOutlet weak var editGoalBtn: UIButton!
    
    @IBOutlet weak var goalLabel: UILabel!
    @IBOutlet weak var reasonLabel: UILabel!
    
    @IBOutlet weak var detailView: UIView!

   //MARK: -- CORE DATA
    var goalss = [Goal]()
    var actionPlan = [ActionPlan]()
    let context  = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var countAllActPlan = 0
    var countDoneActPlan = 0
    var nowPercent = 0
    var desPercent : Double = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configureMyGoalUI()
        getGoalData()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //Fetch action data
        fetchActionData()
//        calculatePercentage()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        desPercent = Double(nowPercent) * 0.01
        print(desPercent)
        
        //MARK: SET CIRCLE PROGRESS BAR SESUAI PERSENTASE
        circleProgressView.calculateForeLayer(strokeEnd: desPercent)
        
        //Set percentLabel
        progressPercentNumLabel.text = "\(nowPercent)"
        
 
        
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
    
    //MARK: FETCH DATA DARI CORE DATA, COUNT JUMLAH DATA SELURUH ACTION PLAN &  ACTION PLAN YG STATUSNYA DONE
    func fetchActionData(){
        //Set Supaya data balik ke 0 sblm di fetch
        countAllActPlan = 0
        countDoneActPlan = 0
        
        actionPlan.removeAll()
        
        //Count jumlah task yg statusnya "complete",
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "ActionPlan")
        do {
            let results: NSArray = try context.fetch(request) as NSArray
                for result in results{
                    countAllActPlan += 1
                    
                    let act = result as! ActionPlan
                    if act.status == "Done"{
                        countDoneActPlan += 1
                    }
                }
        } catch  {
            print("Fetch failed")
        }
        
        print("Jumlah Done ActionPlan: ", countDoneActPlan)
        print("Jumlah Seluruh ActionPlan: ", countAllActPlan)
        calculatePercentage()
    }
    
    func calculatePercentage(){
        let allPercent = 100

        let percentPerAction = allPercent/countAllActPlan
        nowPercent = percentPerAction * countDoneActPlan

        print("Now Percent", nowPercent)
    }

}

