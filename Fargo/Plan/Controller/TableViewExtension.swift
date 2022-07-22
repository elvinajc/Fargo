//
//  TableViewExtension.swift
//  Fargo
//
//  Created by Elvina Jacia on 22/07/22.
//

import UIKit

extension PlanVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}

extension PlanVC: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //MARK: -- Harusnya return array of data requirement.count
        //Sementara return 1 dlu buat coba
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "reqCell", for : indexPath) as? RequirementCell{
            
        //MARK: -- Harusnya cell.reqTitle.text = self."namaArray"[indexPath.row]
            //Sementara isi asal dulu:
        //    cell.reqTitle.text = "ABCDEFG"
            
            cell.layer.cornerRadius = 8
            cell.reqCellView.layer.cornerRadius = 8
            //cell.reqCellView.layer.masksToBounds = true
            
            return cell
        }
        
        return UITableViewCell()
    }
    
    
}
