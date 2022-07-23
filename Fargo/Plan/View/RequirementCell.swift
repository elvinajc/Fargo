//
//  RequirementCell.swift
//  Fargo
//
//  Created by Elvina Jacia on 22/07/22.
//

import UIKit

class RequirementCell: UITableViewCell {

    @IBOutlet weak var reqCellView: UIView!
    @IBOutlet weak var reqTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

      
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    
        reqCellView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4).isActive = true
        reqCellView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 4).isActive = true
        reqCellView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -4).isActive = true
        reqCellView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4).isActive = true
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
    }
    

    
}
