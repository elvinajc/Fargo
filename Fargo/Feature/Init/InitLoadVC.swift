//
//  InitLoadVC.swift
//  Fargo
//
//  Created by Elvina Jacia on 25/07/22.
//

import CoreData
import UIKit

class InitLoadVC: UIViewController {

    //MARK: CORE DATA START
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var goals: [Goal] = [Goal]()
    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        // Do any additional setup after loading the view.
//     //   checkTheGoal()
//    }

    override func viewDidAppear(_ animated: Bool) {
        checkTheGoal()
    }
    
    //MARK: CORE DATA FUNC

        func checkTheGoal(){
            do {
                self.goals = try context.fetch(Goal.fetchRequest())

                if self.goals.isEmpty{
                    print("BELUM ADA GOALS")
                    self.performSegue(withIdentifier: "goToGoalSettingFL", sender: self)
                   
                } else {
                    print("SUDAH ADA GOAL, jadi ke tabbar")
                    performSegue(withIdentifier: "goToTabBarFL", sender: self)
                }
               
            }
            catch {
                print("error")
            }
        }

}
