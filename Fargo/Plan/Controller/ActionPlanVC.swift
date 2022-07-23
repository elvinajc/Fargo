//
//  ActionPlanVC.swift
//  Fargo
//
//  Created by Elvina Jacia on 23/07/22.
//


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

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.tabBarController?.tabBar.isHidden = true
        
        // Do any additional setup after loading the view.
        configureUIActPlan()
        
        //MARK: -- CEK DATA DI CORE DATA, KALO GA ADA, isHidden = false | KALO ADA, isHidden = true
        //Sementara: is hidden = false
        noActPlanLabel.isHidden = false
        
        //TableView
         self.actTableView.register(UINib(nibName: "ActionCell", bundle: nil), forCellReuseIdentifier: "actCell")
         actTableView.delegate = self
         actTableView.dataSource = self
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    
    //Func
    @IBAction func addActBtnAction(_ sender: UIBarButtonItem) {
      //MARK: -- perform segue ke action plan detail
      //  self.performSegue(withIdentifier: <#T##String#>, sender: <#T##Any?#>)
    }
    
    func configureUIActPlan(){
        configureReqView()
        setRoundedActProgView()
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
    
    
}

