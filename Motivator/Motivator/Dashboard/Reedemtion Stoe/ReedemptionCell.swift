//
//  ReedemptionCell.swift
//  Motivator
//
//  Created by Anshul Jain on 13/12/20.
//

import UIKit

class ReedemptionCell: UITableViewCell {
    @IBOutlet var viewLay: UIView!{
        didSet{
            viewLay.layer.cornerRadius = 10
            viewLay.addShadow()
        }
    }
    @IBOutlet var imageReedemption: UIImageView!{
        didSet{
            imageReedemption.layer.cornerRadius = imageReedemption.frame.size.width/2
        }
    }
    @IBOutlet var labelName: UILabel!
    
    func configure(model: ReedemptionModel){
        labelName.text = model.name
        imageReedemption?.backgroundColor = model.color
    }
}
