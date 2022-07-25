//
//  PlanVC.swift
//  Fargo
//
//  Created by Elvina Jacia on 20/07/22.
//

import UIKit

class PlanVC: UIViewController {
    
    //Properties
    @IBOutlet weak var infoView: UIView!
    @IBOutlet weak var reqDetailView: UIView!
    @IBOutlet weak var noRequirementLabel: UILabel!
    @IBOutlet weak var addReqBtn: UIBarButtonItem!
    
    @IBOutlet weak var reqTableView: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = false
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        // Do any additional setup after loading the view.
        configureUIPlan()
        
        //MARK: -- CEK DATA DI CORE DATA, KALO GA ADA, isHidden = false | KALO ADA, isHidden = true
        //Sementara: is hidden = false
        noRequirementLabel.isHidden = false
        
        //DELEGATE + DATA SOURCE
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        //Set left nav bar item titlenya dari back ke kosong
           let backItem = UIBarButtonItem()
           backItem.title = ""
           navigationItem.backBarButtonItem = backItem
        
        //MARK: -- Passing row yg di select + datanya ke halaman action plan
        if (segue.identifier == "goToActionPlan"){
            let indexPath = reqTableView.indexPathForSelectedRow!
            let actionPlan = segue.destination as? ActionPlanVC
           // let selectedRequirement : RequirementData!
           // selectedRequirement = showIdeasList[indexPath.row]
           // actionPlan!.selectedRequirement = selectedRequirement
            reqTableView.deselectRow(at: indexPath, animated: true)
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
        //Register Pakai Cara Manual:
        //self.reqTableView.register(UINib(nibName: "RequirementCell", bundle: nil), forCellReuseIdentifier: "reqCell")
        
        //Register Pakai Helper (UINib + Loader):
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
               
            //MARK: --SAVE REQUIREMENT TITLE TO CORE DATA
                print("Requirement Title: \(title.text!)")
                
            })
        
            let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: { (action : UIAlertAction!) -> Void in })

            alertController.addAction(cancelAction)
            alertController.addAction(saveAction)
        
            //Bikin save button lebih di bold
            alertController.preferredAction = saveAction
        
            self.present(alertController, animated: true, completion: nil)
 
    }
    
    
    func loadEditAlert(){
        
            let alertController = UIAlertController(title: "Edit Requirement Title", message: "Change the requirement title", preferredStyle: .alert)
            alertController.addTextField { (textField : UITextField!) -> Void in
                
                //MARK: -- Text Placeholder ambil dari core data (requirement title).
                textField.placeholder = "Tampilin Title Lama"
            }
        
            //Change alert button color:
            UIView.appearance(whenContainedInInstancesOf: [UIAlertController.self]).tintColor = UIColor.darkChoco
            
        
            //Save & delete action
            let saveAction = UIAlertAction(title: "Save", style: .default, handler: { alert -> Void in
                let title = alertController.textFields![0] as UITextField
               
                //MARK: --SAVE REQUIREMENT TITLE TO CORE DATA
                print("Requirement Title Change To: \(title.text!)")
                
            })
        
            let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: { (action : UIAlertAction!) -> Void in })

            alertController.addAction(cancelAction)
            alertController.addAction(saveAction)
        
            //Bikin save button lebih di bold
            alertController.preferredAction = saveAction
        
            self.present(alertController, animated: true, completion: nil)
 
    }
    
}
