//
//  InitialVC.swift
//  Motivator
//
//  Created by Anshul Jain on 13/12/20.
//

import UIKit

class InitialVC: UIViewController {
    @IBOutlet var button:UIButton!{
        didSet{
            button.addShadow()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
