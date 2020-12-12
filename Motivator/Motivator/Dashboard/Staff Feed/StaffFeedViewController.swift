//
//  StaffFeedViewController.swift
//  Motivator
//
//  Created by Ruchi Upgade on 12/12/20.
//

import UIKit

class StaffFeedViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    var staffFeedList = [
        "Stan Dupp posted 2 hours ago - I have made a sell of 5 products today.",
        "Mark Ateer posted 4 hours ago - Feelings fresh on a Monday morning,"
    ]
    @IBAction func backAction(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.reloadData()
        // Do any additional setup after loading the view.
    }

}

extension StaffFeedViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        staffFeedList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value1, reuseIdentifier: "Cell")
        cell.textLabel?.text = staffFeedList[indexPath.row]
        return cell
    }
}
