//
//  UINIB+Loader.swift
//  Fargo
//
//  Created by Elvina Jacia on 24/07/22.
//


import UIKit

extension UINib {
    static func nib(_ nibName: String) -> UINib {
        return UINib(nibName: nibName, bundle: nil)
    }
    
    static func loadSingleView(_ nibName: String, owner: Any?) -> UIView {
        return nib(nibName).instantiate(withOwner: owner, options: nil).first as! UIView
    }
}

extension UINib {
    class func loadView(_ owner: AnyObject) -> UIView {
        return loadSingleView("\(owner.self)", owner: owner)
    }
    
}

//Register Cell with nib
extension UITableView {
    func registerCell(type: UITableViewCell.Type, identifier: String) {
        let nib = UINib.nib("\(type)")
        self.register(nib, forCellReuseIdentifier: identifier)
    }
}




