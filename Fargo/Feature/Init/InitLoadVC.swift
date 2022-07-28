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
    
    override func viewDidAppear(_ animated: Bool) {
        checkTheGoal()
    }
    
    //MARK: CORE DATA FUNC
        func checkTheGoal(){
            do {
                self.goals = try context.fetch(Goal.fetchRequest())

                if self.goals.isEmpty{
                    //Blm ada goal
                    self.performSegue(withIdentifier: "goToGoalSettingFL", sender: self)
                   
                } else {
                    //Sudah ada goal
                    performSegue(withIdentifier: "goToTabBarFL", sender: self)
                }
               
            }
            catch {
                print("error")
            }
        }

}
