//
//  LoginViewController.swift
//  Motivator
//
//  Created by Anshul Jain on 10/12/20.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet var button:UIButton!{
        didSet{
            button.addShadow()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
   @IBAction func sign_InClicked(){
        performSegue(withIdentifier: "dashboard", sender: nil)
    }
    

}
