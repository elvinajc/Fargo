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
    
    //MARK: PROPERTIES CORE DATA
    var requirements = [Requirement]()
    var selectedRequirement: Requirement? = nil

    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = true
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        
        // Do any additional setup after loading the view.
        configureUIActPlan()
        
        //DELEGATE + DATA SOURCE
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        //Set left nav bar item titlenya dari back ke kosong
           let backItem = UIBarButtonItem()
           backItem.title = ""
           navigationItem.backBarButtonItem = backItem
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
    
    
}

