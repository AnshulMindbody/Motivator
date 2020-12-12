//
//  SideMenuViewController.swift
//  Motivator
//
//  Created by Anshul Jain on 10/12/20.
//

import UIKit

class SideMenuViewController: UIViewController {
    
    @IBOutlet var tableView:UITableView!
    let sideList = ["User Profile", "Logout", "Staff Feed", "Comments"]

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Welcome User"
    }
}

extension SideMenuViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 2 {
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "StaffFeedViewController") as! StaffFeedViewController
            self.navigationController?.present(newViewController, animated: true, completion: nil)
        }
    }
}

extension SideMenuViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        sideList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value1, reuseIdentifier: "Cell")
        cell.textLabel?.text = sideList[indexPath.row]
        return cell
    }
}

