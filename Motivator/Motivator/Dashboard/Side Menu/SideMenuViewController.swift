//
//  SideMenuViewController.swift
//  Motivator
//
//  Created by Anshul Jain on 10/12/20.
//

import UIKit

enum Section: CaseIterable {
    case userProfile
    case staffFeed
    case customerComments
    case logut
    
    var title: String{
        switch self {
        case .userProfile:
            return "User Profile"
        case .staffFeed:
            return "Staff Feed"
        case .customerComments:
            return "Customer Comments"
        case .logut:
            return "Logout"
        }
    }
    
}

class SideMenuViewController: UIViewController {
    
    @IBOutlet var tableView:UITableView!
    let sideList = Section.allCases

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Welcome User"
    }
}

extension SideMenuViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let section = sideList[indexPath.row]
        if section == .staffFeed{
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "StaffFeedViewController") as! StaffFeedViewController
            self.navigationController?.present(newViewController, animated: true, completion: nil)
        }
        if section == .customerComments{
            performSegue(withIdentifier: "customerComment", sender: nil)
        }
    }
}

extension SideMenuViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        sideList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value1, reuseIdentifier: "Cell")
        cell.textLabel?.text = sideList[indexPath.row].title
        return cell
    }
}

