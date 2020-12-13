//
//  CustomerCommentVC.swift
//  Motivator
//
//  Created by Anshul Jain on 13/12/20.
//

import UIKit
import Alamofire
import JGProgressHUD

struct CustomerComments:Decodable {
    let rating:String
    let comment:String
}

class CustomerCommentVC: UIViewController {
    
    var commentList  = [CustomerComments]()
    @IBOutlet var tableView:UITableView! {
        didSet{
            tableView.tableFooterView = UIView()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Customer Feedback"
         let hud =  JGProgressHUD()
          hud.show(in: self.view)
        AF.request("http://localhost:3000/notes").validate().responseDecodable(of: [CustomerComments].self) { response in
            DispatchQueue.main.async {
            guard let  commentList = response.value else {
                return
            }
                self.commentList = commentList
                hud.dismiss()
                self.tableView.reloadData()
            }
        }
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

extension CustomerCommentVC: UITableViewDelegate{
    
}

extension CustomerCommentVC:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        commentList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomerCommentCell") as! CustomerCommentCell
        cell.configure(model: commentList[indexPath.row])
        return cell
    }
    
    
}
