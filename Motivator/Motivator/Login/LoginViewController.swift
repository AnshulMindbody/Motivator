//
//  LoginViewController.swift
//  Motivator
//
//  Created by Anshul Jain on 10/12/20.
//

import UIKit
import JGProgressHUD


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
    let hud = JGProgressHUD()
    hud.textLabel.text = "Loading"
    hud.show(in: self.view)
    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
        // your code here
        hud.dismiss()
        self.performSegue(withIdentifier: "dashboard", sender: nil)
    }
    }
    

}
