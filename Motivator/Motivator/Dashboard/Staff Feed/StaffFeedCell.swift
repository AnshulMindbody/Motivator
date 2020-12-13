//
//  StaffFeedCell.swift
//  Motivator
//
//  Created by Anshul Jain on 13/12/20.
//

import UIKit

class StaffFeedCell: UITableViewCell {
    @IBOutlet var viewLay:UIView!{
        didSet{
            viewLay.layer.cornerRadius = 10
            viewLay.addShadow()
        }
    }
    @IBOutlet var nameLabel:UILabel!
    @IBOutlet var commentLabel:UILabel!
    
    func configure(model:StaffComment){
        nameLabel.text = model.name
        commentLabel.text = model.comment
    }

    
}
