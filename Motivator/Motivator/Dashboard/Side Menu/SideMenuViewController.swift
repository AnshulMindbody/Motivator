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
    case redemptionStore
    case logut
    
    var title: String {
        switch self {
        case .userProfile:
            return "User Profile"
        case .staffFeed:
            return "Staff Feed"
        case .customerComments:
            return "Customer Feedback"
        case .redemptionStore:
            return "Redemption Store"
        case .logut:
            return "Logout"
        }
    }
    
    var icon: String {
        switch self {
        case .userProfile:
            return "UserProfile.png"
        case .staffFeed:
            return "StaffFeed.png"
        case .customerComments:
            return "CustomerComments.png"
        case .redemptionStore:
            return "redemption.png"
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
        title = "Welcome Anshul"
        
        tableView.register(UINib(nibName: "SideMenuTableViewCell", bundle: nil), forCellReuseIdentifier: "SideMenuTableViewCell")
    }
}

extension SideMenuViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let section = sideList[indexPath.row]
        if section == .staffFeed {
            performSegue(withIdentifier: "staff", sender: nil)
        }
        if section == .customerComments{
            performSegue(withIdentifier: "customerComment", sender: nil)
        }
        else if section ==  .redemptionStore{
            performSegue(withIdentifier: "redemptionStore", sender: nil)
        }
    }
}

extension SideMenuViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        sideList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SideMenuTableViewCell") as! SideMenuTableViewCell
        cell.menuName?.text = sideList[indexPath.row].title
        cell.menuIcon?.image = UIImage(imageLiteralResourceName: sideList[indexPath.row].icon)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}

