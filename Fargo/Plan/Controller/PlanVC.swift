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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configureUIPlan()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    
    //Func
    
    @IBAction func addReqBtnAct(_ sender: UIBarButtonItem) {
        
        //Munculin alert utk add requirement
        print("ADD REQUIREMENT")
        
        loadAlert()
        
        
    }
    
    
    func configureUIPlan(){
        configureInfoView()
    }

    func configureInfoView(){
        //Set info view to rounded corner
        infoView.layer.cornerRadius = 7
        infoView.layer.borderWidth = 1
        infoView.layer.borderColor = UIColor.brownBorder.cgColor
        
        setRoundedDetView()
    
    }
    
    func setRoundedDetView(){
        reqDetailView.clipsToBounds = true
        reqDetailView.layer.cornerRadius = 20
        // Round Top right corner, Top left corner
        reqDetailView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
    }
    
    func loadAlert(){
//        let alert = UIAlertController(title: "Add New Requirement", message: "Write the requirement title", preferredStyle: .alert)
//
//        alert.addAction(UIAlertAction(title: "Save", style: .default, handler: { action in
//
//            switch action.style{
//                case .default:
//                print("default")
//
//                case .cancel:
//                print("cancel")
//
//                case .destructive:
//                print("destructive")
//
//            }
//        }))
//        self.present(alert, animated: true, completion: nil)
//    }
        
            let alertController = UIAlertController(title: "Add New Requirement", message: "Write the requirement title", preferredStyle: .alert)
            alertController.addTextField { (textField : UITextField!) -> Void in
                textField.placeholder = "Requirement title here"
            }
        
            //Change alert button color:
            UIView.appearance(whenContainedInInstancesOf: [UIAlertController.self]).tintColor = UIColor.darkChoco
            
        
            //Save & delete action
            let saveAction = UIAlertAction(title: "Save", style: .default, handler: { alert -> Void in
                let title = alertController.textFields![0] as UITextField
               
                //MARK: --SAVE REQUIREMENT TITLE TO CORE DATA
                print(title.text)
                
            })
        
            let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: { (action : UIAlertAction!) -> Void in })

            alertController.addAction(cancelAction)
            alertController.addAction(saveAction)
        
            //Bikin save lebih di highlight
            alertController.preferredAction = saveAction
        
            self.present(alertController, animated: true, completion: nil)
        
        
    }
    
}
