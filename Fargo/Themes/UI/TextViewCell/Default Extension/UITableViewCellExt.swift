//
//  UITableViewCellExt.swift
//  Fargo
//
//  Created by Elvina Jacia on 24/07/22.
//
import UIKit

extension UITableViewCell {
    func removeSectionSeparators() {
        for subview in subviews {
            if subview != contentView && subview.frame.width == frame.width {
                subview.removeFromSuperview()
            }
        }
    }
}
