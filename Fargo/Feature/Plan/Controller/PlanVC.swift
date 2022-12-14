//
//  PlanVC.swift
//  Fargo
//
//  Created by Elvina Jacia on 20/07/22.
//

import CoreData
import UIKit


class PlanVC: UIViewController {
    
    //Properties
    @IBOutlet weak var infoView: UIView!
    @IBOutlet weak var reqDetailView: UIView!
    @IBOutlet weak var noRequirementLabel: UILabel!
    @IBOutlet weak var addReqBtn: UIBarButtonItem!
    
    @IBOutlet weak var reqTableView: UITableView!
    
    //MARK: CORE DATA PROPERTIES
    var goals = [Goal]()
    var requirements = [Requirement]()
    var reqTitle = ""
    var editPlaceHD = ""
    var firstLoad = true
    let context  = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = false
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        // Do any additional setup after loading the view.
        configureUIPlan()
        
        if(firstLoad){
            firstLoad = false
            fetchRequirementData()
        }
        
        //MARK: -- CEK DATA DI CORE DATA, KALO GA ADA, isHidden = false | KALO ADA, isHidden = true
        if requirements.isEmpty {
            noRequirementLabel.isHidden = false
        } else {
            noRequirementLabel.isHidden = true
        }

        //DELEGATE + DATA SOURCE
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        //Set left nav bar item titlenya from back ke ""
           let backItem = UIBarButtonItem()
           backItem.title = ""
           navigationItem.backBarButtonItem = backItem
        
        //MARK: -- Passing row yg di select + datanya ke halaman action plan
        if segue.identifier == "goToActionPlan" {
            let indexPath = reqTableView.indexPathForSelectedRow!
            let actionPlan = segue.destination as? ActionPlanVC
            let selectedRequirement : Requirement!
            selectedRequirement = requirements[indexPath.row]
            actionPlan!.selectedRequirement = selectedRequirement
            reqTableView.deselectRow(at: indexPath, animated: true)
        }
    
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        reqTableView.reloadData()
        
        if requirements.isEmpty {
            noRequirementLabel.isHidden = false
        } else {
            noRequirementLabel.isHidden = true
        }

    }
    
    //Func
    
    @IBAction func addReqBtnAct(_ sender: UIBarButtonItem) {
        //Munculin alert utk add requirement
        loadAddAlert()
    }
    
    
    func configureUIPlan(){
        configureInfoView()
        setRoundedDetView()
        setTableView()
    }

    func configureInfoView(){
        //Set info view to rounded corner
        infoView.layer.cornerRadius = 7
        infoView.layer.borderWidth = 1
        infoView.layer.borderColor = UIColor.brownBorder.cgColor
    }
    
    func setRoundedDetView(){
        reqDetailView.clipsToBounds = true
        reqDetailView.layer.cornerRadius = 20
        // Round Top right corner, Top left corner
        reqDetailView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
    }
    
    func setTableView(){
        //Register Table View Cell
        regisTableViewCell()
        
        //Delegate + Data Source
        reqTableView.delegate = self
        reqTableView.dataSource = self
    }
    
    func regisTableViewCell(){
        //Register Manually:
        //self.reqTableView.register(UINib(nibName: "RequirementCell", bundle: nil), forCellReuseIdentifier: "reqCell")
        
        //Register using helper (UINib + Loader):
        reqTableView.registerCell(type: RequirementCell.self, identifier: "reqCell")
    }
    
    func loadAddAlert(){
        
            let alertController = UIAlertController(title: "Add New Requirement", message: "Write the requirement title", preferredStyle: .alert)
            alertController.addTextField { (textField : UITextField!) -> Void in
                textField.placeholder = "Write max. 30 characters"
            }
        
            //Change alert button color:
            UIView.appearance(whenContainedInInstancesOf: [UIAlertController.self]).tintColor = UIColor.darkChoco
            
        
            //Save & delete action
            let saveAction = UIAlertAction(title: "Save", style: .default, handler: { alert -> Void in
            let title = alertController.textFields![0] as UITextField
                self.reqTitle = title.text!
               
            //MARK: --SAVE REQUIREMENT TITLE TO CORE DATA
               // print("Requirement Title: \(title.text!)")
                self.saveRequirementData()
                
            })
        
            let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: { (action : UIAlertAction!) -> Void in })

            alertController.addAction(cancelAction)
            alertController.addAction(saveAction)
        
            //Bikin save button lebih di bold
            alertController.preferredAction = saveAction
        
            self.present(alertController, animated: true, completion: nil)
 
    }
    
    
    
    //MARK: -- FUNC SAVE REQUIREMENT KE CORE DATA
    
    func saveRequirementData(){
        let entity = NSEntityDescription.entity(forEntityName: "Requirement", in: context)
        
        // Create a req obj
        let newReq = Requirement(entity: entity!, insertInto: context)
        newReq.setValue(self.reqTitle, forKey: "requirementTitle")
        
        // Save req data
        do {
            //MARK: --Coba Add Req to the goal
            let goal = Goal(context: context)
            goal.addToRequirement(newReq)

            try context.save()
            
            //Tambahin ke arraylist
            requirements.append(newReq)
            
            DispatchQueue.main.async {
                self.reqTableView.reloadData()
                
                if self.requirements.isEmpty {
                    self.noRequirementLabel.isHidden = false
                } else {
                    self.noRequirementLabel.isHidden = true
                }
            }
            
        } catch {
            print(error)
        }
    

    }
    
    func fetchRequirementData(){
        let request = NSFetchRequest<NSFetchRequestResult> (entityName: "Requirement")
        
        do{
            let results : NSArray = try context.fetch(request) as NSArray
            for result in results {
                let req = result as! Requirement
                requirements.append(req)
                
                DispatchQueue.main.async {
                    self.reqTableView.reloadData()
                }
            }
        }catch{
            print(error)
        }
    }
    
    
}
