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
    @IBOutlet weak var profileImageView: UIImageView!
    
    func configure(model:StaffComment){
        nameLabel.text = model.name
        commentLabel.text = model.comment
        profileImageView.setImageForName(model.name, backgroundColor: .blue, circular: true, textAttributes: [NSAttributedString.Key(rawValue: NSAttributedString.Key.font.rawValue): UIFont(name: "OpenSans-SemiBold", size: 30)!, NSAttributedString.Key(rawValue: NSAttributedString.Key.foregroundColor.rawValue): UIColor.init(white: 1.0, alpha: 0.5)])
    }

    
}
