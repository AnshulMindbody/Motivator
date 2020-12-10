//
//  SideMenuViewController.swift
//  Motivator
//
//  Created by Anshul Jain on 10/12/20.
//

import UIKit

class SideMenuViewController: UIViewController {
    
    @IBOutlet var tableView:UITableView!
    let sideList = ["User Profile", "Logout"]

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Welcome User"
    }
}

extension SideMenuViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
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

