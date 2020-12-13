//
//  LeaderboardTableViewCell.swift
//  Motivator
//
//  Created by Ruchi Upgade on 12/11/20.
//

import UIKit

class LeaderboardTableViewCell: UITableViewCell {

    @IBOutlet weak var containerViewLay: UIView!{
        didSet{
            containerViewLay.layer.cornerRadius = 10.0
            containerViewLay.addShadow()
        }
    }
    @IBOutlet weak var profileImageview: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var levelLabel: UILabel!

    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        profileImageview.layer.cornerRadius = profileImageview.frame.size.height/2
    }
}
