//
//  DailyChallengeTableViewCell.swift
//  Motivator
//
//  Created by Anshul Jain on 13/12/20.
//

import UIKit

class DailyChallengeTableViewCell: UITableViewCell {
    
    @IBOutlet var labelName: UILabel!
    @IBOutlet var rejectButton: UIButton!
    @IBOutlet var acceptButton: UIButton!
    @IBOutlet var viewCell: UIView!{
        didSet{
            viewCell.layer.cornerRadius = 10
            viewCell.addShadow()
        }
    }
    
    override func prepareForReuse() {
        rejectButton.isHidden = false
    }
    
    func configure(model: DailyChallenge){
        labelName.text = model.name
        if model.accepted {
            rejectButton.isHidden = true
            acceptButton.setTitle("Accepted", for: .normal)
        } else if model.rejected {
            viewCell.backgroundColor = UIColor.lightGray
            rejectButton.setTitle("Rejected", for: .normal)
        } else {
            acceptButton.setTitle("Accept", for: .normal)
            rejectButton.setTitle("Reject", for: .normal)
        }
    }
    
}
