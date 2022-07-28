//
//  ActionPlanDetailVC.swift
//  Fargo
//
//  Created by Elvina Jacia on 24/07/22.
//
import CoreData
import UIKit

class ActionPlanDetailVC: UIViewController {
    
    
    //Properties
    let actPlanDetTableView = UITableView(frame: .zero, style: .grouped)
    
    //MARK: -- PROPERTIES UTK CORE DATA
    var requirements : Requirement? = nil
    var actionplans = [ActionPlan]()
    let context  = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var selectedActionPlan: ActionPlan? = nil
  
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configureUIActPlanDetail()
        //print("Requirements \(requirements)")
        
    }

    //Func
    
    func configureUIActPlanDetail(){
        confNavBar()
        setTableView()
        addGestureRecDismissKeyboard()
    }
    
    func confNavBar(){
        let doneBtn = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: self, action: #selector(done))
        navigationItem.rightBarButtonItem = doneBtn
        doneBtn.tintColor = .darkChoco
    }

    @objc func done() {
        //MARK: -- SAVE ACTION DETAILS KE CORE DATA
        //Panggil function utk validasi row
        updateActionDetail()
        //print("Action Details Saved")
        
        //perform segue balik ke halaman action plam
        self.navigationController?.popViewController(animated: true)
    }
    
    
    func setTableView(){
        //TableView
        view.addSubview(actPlanDetTableView)
       
        //Register table view cell
        registerCell()
        
        //delegate & data source
        actPlanDetTableView.delegate = self
        actPlanDetTableView.dataSource = self
        
        //layout tableview
        actPlanDetTableView.translatesAutoresizingMaskIntoConstraints = false
        actPlanDetTableView.backgroundColor = .clear
        actPlanDetTableView.separatorColor = .clear
        addTableViewConstraint()
        actPlanDetTableView.isScrollEnabled = true
        
    }
    
    func registerCell(){
        //MARK: -- Register cell :
        //Register Pakai Helper (UINib + Loader):
        actPlanDetTableView.registerCell(type: TextFieldTableViewCell.self, identifier: "TextFieldCell")
        actPlanDetTableView.registerCell(type: TextViewTableViewCell.self, identifier: "TextViewCell")
        actPlanDetTableView.registerCell(type: DatePickerTableViewCell.self, identifier: "DatePickerCell")
        
    }   

    
    func addTableViewConstraint(){
        
        var constraints = [NSLayoutConstraint]()
        
        //ADD Constraint
        constraints.append(actPlanDetTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20))
        constraints.append(actPlanDetTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 20))
        constraints.append(actPlanDetTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0))
        constraints.append(actPlanDetTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10))
        
        constraints.append(actPlanDetTableView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.90 ))
        constraints.append(actPlanDetTableView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor))
        constraints.append(actPlanDetTableView.centerXAnchor.constraint(equalTo: view.centerXAnchor))
        
        //Activate Constraint (Applying)
        NSLayoutConstraint.activate(constraints)
        
    }
    
    
    func addGestureRecDismissKeyboard(){
        //Looks for single or multiple taps.
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    //Calls this function when the tap is recognized.
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    func updateActionDetail() {
        //Name
        let nameIndexPath = IndexPath(row: 0, section: 0)
        guard let actNameCell = actPlanDetTableView.cellForRow(at: nameIndexPath) as? TextFieldTableViewCell,
        let name = actNameCell.textFieldField.text else  { return }
    
           // print("Name : \(name)")
        
        //Desc
        let descIndexPath = IndexPath(row: 0, section: 1)
        guard let descCell = actPlanDetTableView.cellForRow(at: descIndexPath) as? TextViewTableViewCell,
            let desc = descCell.textViewField.text  else { return }
//        if desc != descCell.placeholder {
//            //print("Description : \(desc)")
//        }
        
        //SuccessParameter
        let successIndexPath = IndexPath(row: 0, section: 2)
        guard let successCell = actPlanDetTableView.cellForRow(at: successIndexPath) as? TextViewTableViewCell,
            let success = successCell.textViewField.text  else { return }
//        if success != successCell.placeholder {
//            //print("Success : \(success)")
//        }
        
        //LearningResources
        let learningIndexPath = IndexPath(row: 0, section: 3)
        guard let learningCell = actPlanDetTableView.cellForRow(at: learningIndexPath) as? TextViewTableViewCell,
            let learning = learningCell.textViewField.text  else { return }
//        if learning != learningCell.placeholder {
//           // print("Learning : \(learning)")
//        }
        
        //StartDate
        let sdateIndexPath = IndexPath(row: 0, section: 4)
        guard let sdateCell = actPlanDetTableView.cellForRow(at: sdateIndexPath) as? DatePickerTableViewCell,
            let sdate = sdateCell.dateField.text  else { return }

           // print("Start Date: \(sdate)")
        
        
        //EndDate
        let edateIndexPath = IndexPath(row: 1, section: 4)
        guard let edateCell = actPlanDetTableView.cellForRow(at: edateIndexPath) as? DatePickerTableViewCell,
            let edate = edateCell.dateField.text  else { return }
 
           // print("End Date: \(edate)")
        
        //MARK: ADD ACTION PLAN DATA TO CORE DATA
        if(selectedActionPlan == nil){
            let entity = NSEntityDescription.entity(forEntityName: "ActionPlan", in: context)
            
            // Create action obj
            let newAct = ActionPlan(entity: entity!, insertInto: context)
            newAct.setValue(name, forKey: "actionName")
            newAct.setValue(desc, forKey: "actionDesc")
            newAct.setValue(success, forKey: "successParameter")
            newAct.setValue(learning, forKey: "learningResources")
            newAct.setValue(requirements, forKey: "requirements")
          
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMMMM d, yyyy"
            
            let ssdate = dateFormatter.date(from:sdate)!
            let eedate = dateFormatter.date(from:edate)!
            
            newAct.setValue(ssdate, forKey: "startDate")
            newAct.setValue(eedate, forKey: "endDate")
            newAct.setValue("Undone", forKey: "status")
            
            // Save act data
            do {
                try context.save()
                //Add to arraylist
                actionplans.append(newAct)
            } catch {
                print(error)
            }
        
        } else {
            //MARK: -- EDIT ACTION PLAN DATA KE CORE DATA
            
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "ActionPlan")
            do {
                let results: NSArray = try context.fetch(request) as NSArray
                for result in results{
                    let actPlan = result as! ActionPlan
                    if(actPlan == selectedActionPlan){
                        actPlan.actionName = name
                        actPlan.actionDesc = desc
                        actPlan.successParameter = success
                        actPlan.learningResources = learning
                        
                        let dateFormatter = DateFormatter()
                        dateFormatter.dateFormat = "MMMMM d, yyyy"
                        let ssdate = dateFormatter.date(from:sdate)!
                        let eedate = dateFormatter.date(from:edate)!
                        
                        actPlan.startDate = ssdate
                        actPlan.endDate = eedate
                   
                        try context.save()
  
                        }
                    }
                } catch  {
                    print("Fetch failed")
                }
        }
        
        print("JUMLAH ACTION PLAN: \(actionplans.count)")
    }
    
    
//bracket class
}


