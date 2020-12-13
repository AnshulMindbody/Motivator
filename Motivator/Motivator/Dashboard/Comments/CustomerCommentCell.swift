//
//  CustomerCommentCell.swift
//  Motivator
//
//  Created by Anshul Jain on 13/12/20.
//

import UIKit
import Cosmos

class CustomerCommentCell: UITableViewCell {
    
    @IBOutlet var viewLay:UIView!{
        didSet{
            viewLay.layer.cornerRadius = 10
            viewLay.addShadow()
        }
    }
    @IBOutlet var ratingView:CosmosView!
    @IBOutlet var cutomerComment:UILabel!
    
    func configure(model: CustomerComments){
        if let rating = Double(model.rating) {
        ratingView.rating = rating
        }
        cutomerComment.text = model.comment
    }
}
