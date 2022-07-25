//
//  MyGoalVC.swift
//  Fargo
//
//  Created by Elvina Jacia on 21/07/22.
//

import UIKit


class MyGoalVC: UIViewController {
    
    //Properties
    @IBOutlet weak var progressView: UIView!
    @IBOutlet weak var circleProgressView: UIView!
    
    @IBOutlet weak var progressPercentNumLabel: UILabel!

    @IBOutlet weak var editGoalBtn: UIButton!
    
    @IBOutlet weak var goalLabel: UILabel!
    @IBOutlet weak var reasonLabel: UILabel!
    
    @IBOutlet weak var detailView: UIView!

  
    
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
    }
    
    func setRoundedView(){
        detailView.clipsToBounds = true
        detailView.layer.cornerRadius = 20
        // Round Top right corner, Top left corner 
        detailView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
    }
    
    //MARK: -- FUNC GET DATA FROM CORE DATA
    func getGoalData(){
       //Ambil data goal dari core data & tampilkan ke label yg ada
        print("GET GOAL DATA")
 
      //  goalLabel.text = goalSetting.goalFill
        goalLabel.textColor = .white
        goalLabel.font = UIFont.boldSystemFont(ofSize: 17.0)
        
     //   reasonLabel.text = goalSetting.reasonFill
        
    }
    
    
    //MARK: -- FUNC BUTTON ACTION
    @IBAction func editBtnAction(_ sender: UIButton) {
        self.performSegue(withIdentifier: "goToGoalSetting", sender: self)
    }
    
  
    
    
}

