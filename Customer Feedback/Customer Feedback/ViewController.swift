//
//  ViewController.swift
//  Customer Feedback
//
//  Created by Anshul Jain on 13/12/20.
//

import UIKit
import Cosmos
import Alamofire
import NVActivityIndicatorView
import JGProgressHUD

class ViewController: UIViewController {
    
    @IBOutlet var textView: UITextView!{
        didSet{
            textView.layer.borderWidth = 1
        }
    }
    
    @IBOutlet var ratingView: CosmosView!
    private var rating: String!
    @IBOutlet var buttonSubmit: UIButton!{
        didSet{
            buttonSubmit.addShadow()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        ratingView.didFinishTouchingCosmos = { rating in
            self.rating = String(Int(rating))
        }
        allowHidingKeyboard()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func submitButtonAction(){
        
        struct Comment: Encodable {
            let rating: String
            let comment: String
        }
       

        let login = Comment(rating: rating, comment: textView.text!)
            JGProgressHUD().show(in: self.view)
        AF.request("http://localhost:3000/notes",
                   method: .post,
                   parameters: login,
                   encoder: JSONParameterEncoder.default).response { response in
                    DispatchQueue.main.async {
                        JGProgressHUD().dismiss()
                        self.performSegue(withIdentifier: "ThankYou", sender: nil)
                    }
        }
        
    }
    

}


extension UIView {
func addShadow(shadowColor: CGColor = UIColor.black.cgColor,
                   shadowOffset: CGSize = CGSize(width: 1.0, height: 2.0),
                   shadowOpacity: Float = 0.4,
                   shadowRadius: CGFloat = 3.0) {
        layer.shadowColor = shadowColor
        layer.shadowOffset = shadowOffset
        layer.shadowOpacity = shadowOpacity
        layer.shadowRadius = shadowRadius
        layer.masksToBounds = false
    }
}

extension UIViewController {

    func allowHidingKeyboard() {
        let tap = UITapGestureRecognizer(target: self,
                                         action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
