//
//  TodoListTableViewCell.swift
//  Motivator
//
//  Created by Ruchi Upgade on 12/11/20.
//

import UIKit

class TodoListTableViewCell: UITableViewCell {

    @IBOutlet var viewLay: UIView!{
        didSet{
            viewLay.layer.cornerRadius = 10
            viewLay.addShadow()
        }
    }
    
    @IBOutlet var labelName:UILabel!
}
