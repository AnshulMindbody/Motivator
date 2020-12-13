//
//  ReedemptionStoreVC.swift
//  Motivator
//
//  Created by Anshul Jain on 13/12/20.
//

import UIKit

struct ReedemptionModel {
    let name:String
    let color: UIColor
}

class RedemptionStoreVC: UIViewController {
    @IBOutlet var tableView: UITableView!
    let redemptions = [ReedemptionModel(name: "Get Amazon gift card worth $300 for 200 points.", color: .red),
                        ReedemptionModel(name: "Burn 150 points to get a change of earning $50", color: .orange),
                        ReedemptionModel(name: "Get  Netflix membership for a month with 1000 points", color: .green)]

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Redemption Store" 

        // Do any additional setup after loading the view.
    }
    
}

extension RedemptionStoreVC: UITableViewDelegate{
    
}

extension RedemptionStoreVC: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        140
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        redemptions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReedemptionCell", for: indexPath) as! ReedemptionCell
        cell.configure(model: redemptions[indexPath.row])
        return cell
    }
    
    
}
