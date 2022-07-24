//
//  ActDetailTableViewExtension.swift
//  Fargo
//
//  Created by Elvina Jacia on 24/07/22.
//

import UIKit

extension ActionPlanDetailVC : UITableViewDelegate {
    
}


extension ActionPlanDetailVC : UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
       return ActPlanDetailCellSection.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section {
            case 0 : return 1
            case 1 : return 1
            case 2 : return 1
            case 3 : return 1
            case 4 : return 2
            default: return 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .clear
        
        //Set Section Title
        let title = UILabel()
        title.font = UIFont.boldSystemFont(ofSize: 17)
        title.textColor = .darkGreen
        title.text = ActPlanDetailCellSection(rawValue: section)?.description
        
        view.addSubview(title)
        
        title.translatesAutoresizingMaskIntoConstraints = false
        title.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        title.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        
        return view
    }
    
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        <#code#>
//    }
//
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Test", for: indexPath)
    

          // cell.layer.cornerRadius = 8
          //cell.actCellView.layer.cornerRadius = 8
        
        switch indexPath.section {
            case 0 : cell.backgroundColor = .darkChoco
            case 1 : cell.backgroundColor = .darkGray
            case 2 : cell.backgroundColor = .lilDarkGray
            case 3 : cell.backgroundColor = .softEmeraldGreen
            case 4 : cell.backgroundColor = .blue
            default: break
        }
            

            return cell
    }

    
    
}
