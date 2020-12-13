//
//  UpcomingAppointmentTableViewCell.swift
//  Motivator
//
//  Created by Ruchi Upgade on 12/12/20.
//

import UIKit

class UpcomingAppointmentTableViewCell: UITableViewCell {
    
    @IBOutlet var containerViewLay:UIView! {
        didSet{
            containerViewLay.layer.cornerRadius = 10.0
            containerViewLay.addShadow()
        }
    }
    @IBOutlet var labelName:UILabel!
}
