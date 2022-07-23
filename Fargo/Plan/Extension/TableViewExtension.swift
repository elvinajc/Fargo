//
//  TableViewExtension.swift
//  Fargo
//
//  Created by Elvina Jacia on 22/07/22.
//

import UIKit

extension PlanVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        //cell view height + dikit buat spacing (60 + 2)
        return 62
    }
    
    func tableView(_ tableView: UITableView, willBeginEditingRowAt indexPath: IndexPath) {
        //Set Trailing Swipe Action Height
           if let cell = tableView.cellForRow(at: indexPath) as? RequirementCell{
               if let trailingCell = cell.superview{
                   for trailingSwipe in trailingCell.subviews{
                       let typeview = type(of: trailingSwipe.self)
                       if typeview.description() == "UISwipeActionPullView"{
                           trailingSwipe.frame.size.height = 60//size of swipe action
                           trailingSwipe.frame.origin.y = 0 //start position of y
                       }
                   }
               }
           }
       }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        //Component of Edit Action
        let edit = UIContextualAction(style: .normal, title: "Edit") { [weak self] (action, view, completionHandler) in
            //self?.deleteData(ideaTitle: showIdeasList[indexPath.row].ideasTitle!)
            //showIdeasList.remove(at: indexPath.row)
            completionHandler(true)
        }
        edit.backgroundColor = UIColor.lilDarkGray
        
        //Component of Delete Action
        let delete = UIContextualAction(style: .normal, title: "Delete") { [weak self] (action, view, completionHandler) in
            //self?.deleteData(ideaTitle: showIdeasList[indexPath.row].ideasTitle!)
            //showIdeasList.remove(at: indexPath.row)
            completionHandler(true)
        }
        delete.backgroundColor = UIColor.redTomato
        

        let configuration = UISwipeActionsConfiguration(actions: [delete, edit])
        configuration.performsFirstActionWithFullSwipe = false
        
        return configuration
    }
    ///////
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //MARK: -- KALAU ROWNYA DI SELECT, DIA AKAN MASUK KE HALAMAN ACTION PLAN
        //self.performSegue(withIdentifier: "editIdeas", sender: self)
    }
    
    
}

extension PlanVC: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //MARK: -- Harusnya return array of data requirement.count
        //Sementara return 1 dlu buat coba
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "reqCell", for : indexPath) as? RequirementCell{
        //MARK: -- Harusnya cell.reqTitle.text = self."namaArray"[indexPath.row]
            //Sementara isi asal dulu:
        //    cell.reqTitle.text = "ABCDEFG"

            cell.layer.cornerRadius = 8
            cell.reqCellView.layer.cornerRadius = 8
            

            return cell
        }

        return UITableViewCell()
    }
    
    
    
}
