//
//  LeaderboardTableViewCell.swift
//  Motivator
//
//  Created by Ruchi Upgade on 12/11/20.
//

import UIKit

class LeaderboardTableViewCell: UITableViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var profileImageview: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var rankImageview: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        profileImageview.layer.cornerRadius = profileImageview.frame.size.height/2
        containerView.layer.cornerRadius = 10
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
