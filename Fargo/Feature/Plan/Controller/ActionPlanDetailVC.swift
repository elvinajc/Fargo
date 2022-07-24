//
//  ActionPlanDetailVC.swift
//  Fargo
//
//  Created by Elvina Jacia on 24/07/22.
//

import UIKit

class ActionPlanDetailVC: UIViewController {
    
    
    //Properties
    let actPlanDetTableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        configureUIActPlanDetail()
        
        
    }

    //Func
    
    func configureUIActPlanDetail(){
        confNavBar()
        setTableView()
//        confTextView()
        addGestureRecDismissKeyboard()
    }
    
    func confNavBar(){
        let doneBtn = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: self, action: #selector(done))
        navigationItem.rightBarButtonItem = doneBtn
        doneBtn.tintColor = .darkChoco
    }

    @objc func done() {
        //MARK: -- SAVE GOAL & REASON KE CORE DATA
        print("doness")
        
//        print(goalField.text as Any)
//        print(reasonField.text as Any)
        
        //perform segue balik ke halaman action plam
        //self.performSegue(withIdentifier: "goToActionPlan", sender: self)
        self.navigationController?.popViewController(animated: true)
        
    }
    
    
    func setTableView(){
        //TableView
        //self.actTableView.register(UINib(nibName: "ActionCell", bundle: nil), forCellReuseIdentifier: "actCell")
        
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
        
        //Row heightnya dinamis sesuai masing masing cell
        //actPlanDetTableView.rowHeight = 44
    }
    
    func registerCell(){
        //MARK: -- Register cell :
        //Register ngetes
        actPlanDetTableView.register(UITableViewCell.self, forCellReuseIdentifier: "Test")
        
        //Register NIB Cell
        //Register Pakai Cara Manual:
        //self.actTableView.register(UINib(nibName: "ActionCell", bundle: nil), forCellReuseIdentifier: "actCell")

        //Register Pakai Helper (UINib + Loader):
        actPlanDetTableView.registerCell(type: TextFieldTableViewCell.self, identifier: "TextFieldCell")
        actPlanDetTableView.registerCell(type: TextViewTableViewCell.self, identifier: "TextViewCell")
        //actPlanDetTableView.registerCell(type: TextViewTableViewCell.self, identifier: "DatePickerCell")
    }
        
      
    
    func addTableViewConstraint(){
        
        var constraints = [NSLayoutConstraint]()
        
        //ADD Constraint
        constraints.append(actPlanDetTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20)) //jarak 20 dari kiri
        constraints.append(actPlanDetTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 20)) // jarak 20 dari kanan
       // constraints.append(tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 200)) // jarak 200 dari bawah
        constraints.append(actPlanDetTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0)) // jarak 20 dari atas
        
       constraints.append(actPlanDetTableView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.90 )) // lebar tableView 0.90 x dari view
       //constraints.append(tableView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.33 )) // tinggi tableView 0.33 x dari view
        constraints.append(actPlanDetTableView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor))
        constraints.append(actPlanDetTableView.centerXAnchor.constraint(equalTo: view.centerXAnchor))
        
        //Activate Constraint (Applying)
        NSLayoutConstraint.activate(constraints)
        
    }
    
    func addGestureRecDismissKeyboard(){
        //Looks for single or multiple taps.
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))

        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
        //tap.cancelsTouchesInView = false

        view.addGestureRecognizer(tap)
    }
    

}
