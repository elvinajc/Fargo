//
//  ActionPlanVC.swift
//  Fargo
//
//  Created by Elvina Jacia on 23/07/22.
//

import CoreData
import UIKit


class ActionPlanVC: UIViewController {
    
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
    var doneCount = 0
    var undoneCount = 0

    var actStatus = ""
    var buttonRow : Int = 0
     
    
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = true
        
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
            fetchActionPlanData()
           // fetchProgressStatus()
        }
        
        actTableView.reloadData()

         if actionplans.isEmpty {
            noActPlanLabel.isHidden = false
         } else {
             noActPlanLabel.isHidden = true
         }

        
        //MARK: -- CEK DATA DI CORE DATA, KALO GA ADA, isHidden = false | KALO ADA, isHidden = true
        if actionplans.isEmpty {
            noActPlanLabel.isHidden = false
        } else {
            noActPlanLabel.isHidden = true
        }

        
        //DELEGATE + DATA SOURCE
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        //Set left nav bar item titlenya dari back ke kosong
           let backItem = UIBarButtonItem()
           backItem.title = ""
           navigationItem.backBarButtonItem = backItem
        
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
        fetchActionPlanData()
       // fetchProgressStatus()
    }
    
    //Func
    @IBAction func addActBtnAction(_ sender: UIBarButtonItem) {
      //MARK: -- perform segue ke action plan detail
        self.performSegue(withIdentifier: "goToAddActionPlan", sender: self)
        print("KEPENCET")
    }
    
    func configureUIActPlan(){
        configureReqView()
        setRoundedActProgView()
        setTableView()
        
        //MARK: -- CEK DATA DI CORE DATA, KALO GA ADA, isHidden = false | KALO ADA, isHidden = true
        //Sementara: is hidden = false
         noActPlanLabel.isHidden = false
        
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
        //Register Pakai Cara Manual:
        //self.actTableView.register(UINib(nibName: "ActionCell", bundle: nil), forCellReuseIdentifier: "actCell")
        
        //Register Pakai Helper (UINib + Loader):
        actTableView.registerCell(type: ActionCell.self, identifier: "actCell")
    }
    
    //MARK: FETCH ACTION PLAN DATA(HARUS DI CEK)
    func fetchActionPlanData(){
        
        actionplans.removeAll()
        
        let request = NSFetchRequest<NSFetchRequestResult> (entityName: "ActionPlan")
//        let pred = NSPredicate(format: "requirements == %@", self.selectedRequirement!.requirementTitle!)
//        request.predicate = pred
        
        do{
            let results : NSArray = try context.fetch(request) as NSArray
            for result in results {
                let act = result as! ActionPlan

                actionplans.append(act)
               
                DispatchQueue.main.async {
                    self.actTableView.reloadData()
                    
                    if self.actionplans.isEmpty {
                        self.noActPlanLabel.isHidden = false
                    } else {
                        self.noActPlanLabel.isHidden = true
                    }
                }
            }
        }catch{
            print(error)
        }
    }
    
    
//    func fetchProgressStatus(){
//        let request = NSFetchRequest<NSFetchRequestResult> (entityName: "ActionPlan")
//
//        do{
//            let results : NSArray = try context.fetch(request) as NSArray
//            let predUndone = NSPredicate(format: "status == %@", "Undone")
//            request.predicate = predUndone
//
//            for result in results {
//                let act = result as! ActionPlan
//
////                undoneCount = act.status!.count - 4
////                print("UNDONE COUNT \(undoneCount)")
//
//                if act.status == "Done"{
//                    doneCount = act.status!.count-2
//                    print("DONE COUNT \(doneCount)")
//                }
//
////                if act.status == "Undone"{
////                    undoneCount = act.status!.count
////                    print("UNDONE COUNT \(undoneCount)")
////                }
//
//            }
//        }catch{
//            print(error)
//        }
//    }
    
    func updateCheckmarkStatus(){
        
        let request = NSFetchRequest<NSFetchRequestResult> (entityName: "ActionPlan")
            do{
                  let results : NSArray = try context.fetch(request) as NSArray
//                  for result in results {
//                      let act = result as! ActionPlan
                      //ganti status sesuai di index = button row menjadi actStatus
                      
                      actionplans[buttonRow].status! = actStatus
                      print("STATUSNYA : \(actionplans[buttonRow].status)")
                      print("ROW YG DIGANTI \(buttonRow)")
                      
                      try context.save()
                //  }
              }catch{
                  print(error)
              }
        
        
   }

    
    //Get checkmarkButton row
   @objc func whichButtonPressed(sender: UIButton) {
       let buttonNumber = sender.tag
        buttonRow = buttonNumber
       print("ROW YG DIPENCET : \(buttonNumber)")
    }
}

