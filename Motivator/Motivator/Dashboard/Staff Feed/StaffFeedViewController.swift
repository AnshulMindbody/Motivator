//
//  StaffFeedViewController.swift
//  Motivator
//
//  Created by Ruchi Upgade on 12/12/20.
//

import UIKit
import JGProgressHUD
import Alamofire

struct StaffComment:Codable {
    let name:String
    let comment:String
}

class StaffFeedViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    var staffFeedList = [StaffComment]()
    @IBAction func backAction(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
         title = "Staff Feed"
         let hud =  JGProgressHUD()
          hud.show(in: self.view)
        AF.request("http://localhost:3000/staff").validate().responseDecodable(of: [StaffComment].self) { response in
            DispatchQueue.main.async {
            guard let  commentList = response.value else {
                return
            }
                self.staffFeedList = commentList
                self.staffFeedList.reverse()
                hud.dismiss()
                self.tableView.reloadData()
            }
        }
        // Do any additional setup after loading the view.
    }

}

extension StaffFeedViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        staffFeedList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StaffFeedCell", for: indexPath) as! StaffFeedCell
        cell.configure(model: staffFeedList[indexPath.row])
        return cell
    }
}
