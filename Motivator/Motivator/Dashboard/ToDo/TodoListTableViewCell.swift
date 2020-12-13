//
//  TodoListTableViewCell.swift
//  Motivator
//
//  Created by Ruchi Upgade on 12/11/20.
//

import UIKit

protocol TodoListTableViewCellDelegate : class {
    func didPressCheckBoxButton(_ tag: Int)
}

class TodoListTableViewCell: UITableViewCell {

    @IBOutlet var viewLay: UIView!{
        didSet{
            viewLay.layer.cornerRadius = 10
            viewLay.addShadow()
        }
    }
    
    @IBOutlet var labelName:UILabel!
    @IBOutlet weak var checkBox: UIButton!
    
    @IBAction func checkBoxAction(_ sender: UIButton) {
        delegate?.didPressCheckBoxButton(sender.tag)
    }
    
    var delegate: TodoListTableViewCellDelegate?
    
    // Images
    let checkedImage = UIImage(named: "tick.png")! as UIImage
    let uncheckedImage = UIImage(named: "untick.png")! as UIImage

    // Bool property
    var isChecked: Bool? {
        didSet{
            if isChecked == true {
                checkBox.setImage(checkedImage, for: .normal)
            } else {
                checkBox.setImage(uncheckedImage, for: .normal)
            }
        }
    }
    
}
