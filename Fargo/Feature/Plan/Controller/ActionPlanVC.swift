//
//  ActionPlanVC.swift
//  Fargo
//
//  Created by Elvina Jacia on 23/07/22.
//

import CoreData
import UIKit

protocol updateProgressLabel{
    func buttonClicked(status: String, numOfDone: Int, buttonRow: Int)
}

class ActionPlanVC: UIViewController, updateProgressLabel {
    func buttonClicked(status: String, numOfDone: Int, buttonRow: Int) {
        //print("STATUS SEKARANG: \(status)")
        actStatus = status
        
        self.buttonRow = buttonRow
        //print("ROW YG DIPENCET : \(buttonRow)")
        updateCheckmarkStatus()
        
        doneCounts += numOfDone
        self.numOfActDone.text = "\(doneCounts)"
        //print(self.actionplans)
        
    }
    
    
    //Properties
    @IBOutlet weak var addActBtn: UIBarButtonItem!
    
    
    @IBOutlet weak var reqTitleLabel: UILabel!
    @IBOutlet weak var reqView: UIView!
    
    @IBOutlet weak var actProgView: UIView!
    @IBOutlet weak var numOfActDone: UILabel!
    @IBOutlet weak var numOfAllAct: UILabel!
    
    @IBOutlet weak var noActPlanLabel: UILabel!
    @IBOutlet weak var actTableView: UITableView!
    
    //MARK: PROPERTIES CORE DATA
    var requirements = [Requirement]()
    var actionplans = [ActionPlan]()
    var selectedRequirement: Requirement? = nil
    var firstLoad = true
    let context  = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext


    var actStatus = ""
    var buttonRow : Int = 0
    
    var doneCounts = 0
     
    
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = true
        
        fetchActionPlanData()
        
        actTableView.reloadData()

         if actionplans.isEmpty {
            noActPlanLabel.isHidden = false
         } else {
             noActPlanLabel.isHidden = true
         }

    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configureUIActPlan()
        
        if (firstLoad) {
            firstLoad = false
           // fetchActionPlanData()
        }
     
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        //Set left nav bar item titlenya dari back ke kosong
           let backItem = UIBarButtonItem()
           backItem.title = ""
           navigationItem.backBarButtonItem = backItem

        if (segue.identifier == "goToAddActionPlan"){
            let destVC = segue.destination as? ActionPlanDetailVC
            destVC?.requirements = selectedRequirement
        }
        
        //Segue utk ke edit
        if (segue.identifier == "goToEditActionPlan"){
            let indexPath = actTableView.indexPathForSelectedRow
            let destVC = segue.destination as? ActionPlanDetailVC
            let selectedActionPlan : ActionPlan!
 
            selectedActionPlan = actionplans[indexPath!.row]
            
            destVC!.selectedActionPlan = selectedActionPlan
            
            actTableView.deselectRow(at: indexPath!, animated: true)
        }
    
    }
    
    override func viewDidAppear(_ animated: Bool) {
       // fetchProgressStatus()
    }
    
    //Func
    @IBAction func addActBtnAction(_ sender: UIBarButtonItem) {
      //MARK: -- perform segue ke action plan detail
        self.performSegue(withIdentifier: "goToAddActionPlan", sender: self)
    }
    
    func configureUIActPlan(){
        configureReqView()
        setRoundedActProgView()
        setTableView()
        
        //MARK: -- Set reqTitleLabel sesuai sama yg dipilih
        reqTitleLabel.text = selectedRequirement?.requirementTitle!
    }

    func configureReqView(){
        //Set info view to rounded corner
        reqView.layer.cornerRadius = 7
        reqView.layer.borderWidth = 1
        reqView.layer.borderColor = UIColor.brownBorder.cgColor
    }
    
    func setRoundedActProgView(){
        actProgView.clipsToBounds = true
        actProgView.layer.cornerRadius = 20
        // Round Top right corner, Top left corner
        actProgView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
    }
    
    func setTableView(){
        //Register Table View Cell
        regisTableViewCell()
        
        //Delegate + Data Source
        actTableView.delegate = self
        actTableView.dataSource = self
    }
    
    func regisTableViewCell(){
        //RegisterCell
        //Register Manually:
        //self.actTableView.register(UINib(nibName: "ActionCell", bundle: nil), forCellReuseIdentifier: "actCell")
        
        //Register Using Helper (UINib + Loader):
        actTableView.registerCell(type: ActionCell.self, identifier: "actCell")
    }
    
    //MARK: FETCH ACTION PLAN DATA(HARUS DI CEK)
    func fetchActionPlanData(){
        doneCounts = 0
        var allActionCount = 0
        
        actionplans.removeAll()
        
        let request = NSFetchRequest<NSFetchRequestResult> (entityName: "ActionPlan")
        let pred = NSPredicate(format: "requirements == %@", self.selectedRequirement!)
        request.predicate = pred
        
        do{
            let results : NSArray = try context.fetch(request) as NSArray
            for result in results {
                let act = result as! ActionPlan

                actionplans.append(act)
               
                
                if act.status == "Done"{
                    doneCounts += 1
                }
            }
        }catch{
            print(error)
        }
        
        
        DispatchQueue.main.async {
            self.actTableView.reloadData()
            
            if self.actionplans.isEmpty {
                self.noActPlanLabel.isHidden = false
            } else {
                self.noActPlanLabel.isHidden = true
            }
            
            self.numOfActDone.text = "\(self.doneCounts)"
            
            allActionCount = self.actionplans.count
            //print("ALL ACTION = \(allActionCount)")
            self.numOfAllAct.text = "\(allActionCount)"
        }
    }
    
    
    func updateCheckmarkStatus(){
        do{
            actionplans[buttonRow].status! = actStatus
            print("STATUSNYA : \(actionplans[buttonRow].status)")
            print("ROW YG DIGANTI \(buttonRow)")
            self.numOfActDone.text = "\(self.doneCounts)"
                
            try context.save()

        }catch{
            print(error)
        }
        
        
   }

    
    //Get checkmarkButton row
//   @objc func whichButtonPressed(sender: UIButton) {
//       let buttonNumber = sender.tag
//        buttonRow = buttonNumber
//       print("ROW YG DIPENCET : \(buttonNumber)")
//       updateCheckmarkStatus()
//    }
}


