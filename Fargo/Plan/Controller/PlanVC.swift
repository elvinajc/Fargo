//
//  PlanVC.swift
//  Fargo
//
//  Created by Elvina Jacia on 20/07/22.
//

import UIKit

class PlanVC: UIViewController {
    @IBOutlet weak var infoView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //Set info view to rounded corner
            infoView.layer.cornerRadius = 7
            infoView.layer.borderWidth = 1
            infoView.layer.borderColor = UIColor.brownBorder.cgColor
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }


}
