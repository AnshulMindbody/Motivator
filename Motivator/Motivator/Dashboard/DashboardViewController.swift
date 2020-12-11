//
//  DashboardViewController.swift
//  Motivator
//
//  Created by Anshul Jain on 10/12/20.
//

import UIKit
import Charts
import Segmentio

final class DashboardViewController: UIViewController, UITextFieldDelegate {
    
    enum DashboardType:String, CaseIterable{
        case leaderboard = "Leaderboard"
        case upcomingAppointment = "Upcoming Appointment"
        case dailyChallenge = "Todo List"
        case todoList = "Staff Feed"
        case staffFeed = "Daily Challenge"
    }
    
    @IBOutlet var pieChartView: PieChartView!
    @IBOutlet var tableView: UITableView! {
        didSet {
            tableView.tableFooterView = UIView()
        }
    }
    @IBOutlet var segmentioView: Segmentio!
    @IBOutlet var floatingButton: UIButton!
    
    var dashBoardList: [String] {
        
        switch dashboardType{
        case .leaderboard:
            floatingButton.isHidden = true
            self.tableView.register(UINib(nibName: "LeaderboardTableViewCell", bundle: nil), forCellReuseIdentifier: "LeaderboardTableViewCell")
         return [
            "Neil DOwn is at Level 27 with 789 score",
            "Allie Grater is at Level 23 with 699 score",
            "Pat Thett is at Level 23 with 600 score",
            ]
        case .upcomingAppointment:
            floatingButton.isHidden = true
            return [
               "upcomingAppointment upcomingAppointment upcomingAppointment upcomingAppointment",
                "upcomingAppointment upcomingAppointment upcomingAppointment upcomingAppointment",
                "upcomingAppointment upcomingAppointment upcomingAppointment upcomingAppointment",
                "upcomingAppointment upcomingAppointment upcomingAppointment upcomingAppointment",
                "upcomingAppointment upcomingAppointment upcomingAppointment upcomingAppointment",
                "upcomingAppointment upcomingAppointment upcomingAppointment upcomingAppointment",
                "upcomingAppointment upcomingAppointment upcomingAppointment upcomingAppointment",
                "upcomingAppointment upcomingAppointment upcomingAppointment upcomingAppointment",
                "upcomingAppointment upcomingAppointment upcomingAppointment upcomingAppointment",
                "upcomingAppointment upcomingAppointment upcomingAppointment upcomingAppointment"
               ]
        case .dailyChallenge:
            floatingButton.isHidden = false
            return [
               "dailyChallenge dailyChallenge dailyChallenge dailyChallenge",
                "dailyChallenge dailyChallenge dailyChallenge dailyChallenge",
                "dailyChallenge dailyChallenge dailyChallenge dailyChallenge",
                "dailyChallenge dailyChallenge dailyChallenge dailyChallenge",
                "dailyChallenge dailyChallenge dailyChallenge dailyChallenge",
                "dailyChallenge dailyChallenge dailyChallenge dailyChallenge",
                "dailyChallenge dailyChallenge dailyChallenge dailyChallenge",
                "dailyChallenge dailyChallenge dailyChallenge dailyChallenge",
                "dailyChallenge dailyChallenge dailyChallenge dailyChallenge"
               ]
        case .todoList:
            floatingButton.isHidden = false
            return todoList
        case .staffFeed:
            floatingButton.isHidden = true
            return [
               "staffFeed staffFeed staffFeed staffFeed",
                "staffFeed staffFeed staffFeed staffFeed",
                "staffFeed staffFeed staffFeed staffFeed",
                "staffFeed staffFeed staffFeed staffFeed",
                "staffFeed staffFeed staffFeed staffFeed",
                "staffFeed staffFeed staffFeed staffFeed",
                "staffFeed staffFeed staffFeed staffFeed",
                "staffFeed staffFeed staffFeed staffFeed",
                "staffFeed staffFeed staffFeed staffFeed",
                "staffFeed staffFeed staffFeed staffFeed",
                "staffFeed staffFeed staffFeed staffFeed",
                "staffFeed staffFeed staffFeed staffFeed"
               ]

        }
    }
    
    var todoList = [String]()
    var proofileImages = ["profile1", "profile2", "profile3"]
    var rankImages = ["rank1", "rank2", "rank3"]
    
    var dashboardType: DashboardType = .leaderboard
    var sections: [DashboardType] = DashboardType.allCases
    var content = [SegmentioItem]()
    
    let players = ["Leo", "Ruchi", "Anshul"]
    let goals = [10, 20, 70]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Dashboard"
        loadPieChart()
        loadSlidingTabControl()
    }
    
}

extension DashboardViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

extension DashboardViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch dashboardType {
        
        case .upcomingAppointment, .dailyChallenge, .staffFeed:
            let cell = UITableViewCell(style: .value1, reuseIdentifier: "Cell")
            cell.textLabel?.numberOfLines = 0
            cell.textLabel?.text = dashBoardList[indexPath.row]
            return cell
        case .leaderboard:
            let cell = tableView.dequeueReusableCell(withIdentifier: "LeaderboardTableViewCell") as! LeaderboardTableViewCell//UITableViewCell(style: .value1, reuseIdentifier: "LeaderboardTableViewCell") as! LeaderboardTableViewCell
            cell.nameLabel?.numberOfLines = 0
            cell.nameLabel?.text = dashBoardList[indexPath.row]
            cell.profileImageview.image = UIImage(named: proofileImages[indexPath.row])
            cell.rankImageview.image = UIImage(named: rankImages[indexPath.row])
            return cell
  
        case .todoList:
            let cell = UITableViewCell(style: .value1, reuseIdentifier: "todoListCell") as! TodoListTableViewCell
            cell.textLabel?.numberOfLines = 0
            cell.textLabel?.text = dashBoardList[indexPath.row]
            return cell            
      
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dashBoardList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch dashboardType {
            
        case .leaderboard:
            return 62
        case .upcomingAppointment:
            return 50
        case .dailyChallenge:
            return 50
        case .todoList:
            return 50
        case .staffFeed:
            return 50
        }
    }
    
}

extension DashboardViewController {
    
    func customizeChart(dataPoints: [String], values: [Double]) {
      
      // 1. Set ChartDataEntry
      var dataEntries: [ChartDataEntry] = []
      for i in 0..<dataPoints.count {
        let dataEntry = PieChartDataEntry(value: values[i], label: dataPoints[i], data: dataPoints[i] as AnyObject)
        dataEntries.append(dataEntry)
      }
      // 2. Set ChartDataSet
        let pieChartDataSet = PieChartDataSet(entries: dataEntries, label: nil)
      pieChartDataSet.colors = colorsOfCharts(numbersOfColor: dataPoints.count)
      // 3. Set ChartData
      let pieChartData = PieChartData(dataSet: pieChartDataSet)

      
      let format = NumberFormatter()
      format.numberStyle = .none
      let formatter = DefaultValueFormatter(formatter: format)
      pieChartData.setValueFormatter(formatter)
      // 4. Assign it to the chart’s data
      pieChartView.data = pieChartData
    }
        
        private func colorsOfCharts(numbersOfColor: Int) -> [UIColor] {
          var colors: [UIColor] = []
          for _ in 0..<numbersOfColor {
            let red = Double(arc4random_uniform(256))
            let green = Double(arc4random_uniform(256))
            let blue = Double(arc4random_uniform(256))
            let color = UIColor(red: CGFloat(red/255), green: CGFloat(green/255), blue: CGFloat(blue/255), alpha: 1)
            colors.append(color)
          }
          return colors

        }
}

extension DashboardViewController {
    
    func loadSlidingTabControl(){
        
        segmentioView.selectedSegmentioIndex = 0
        segmentioView.valueDidChange = {[weak self] segmentio, segmentIndex in
            guard let self = self else {
                return
            }
            self.dashboardType = self.sections[segmentIndex]
            self.tableView.reloadData()
        }
        
        content =   [
            SegmentioItem(
                title: "Leaderboard",
                image: nil
            ),
            SegmentioItem(
                title: "Upcoming Appointment",
                image: nil
            ),
            SegmentioItem(
                title: "Daily Challenge",
                image: nil
            ),
            SegmentioItem(
                title: "Todo List",
                image: nil
            ),
            SegmentioItem(
                title: "Staff Feed",
                image: nil
            ),
        ]
        segmentioView.setup(content: content, style: .onlyLabel, options: nil)
    }
}

extension DashboardViewController {
    func loadPieChart(){
        pieChartView.drawHoleEnabled = false
        customizeChart(dataPoints: players, values: goals.map{ Double($0) })
        
        //      pieChartView.legend.orientation = .vertical
        //      pieChartView.legend.verticalAlignment = .top
        pieChartView.legend.enabled = false
    }
    
    @IBAction func floatingButtonClicked(){
        switch dashboardType {
        case .todoList:
            print("to do clicked")
            let alertController = UIAlertController(title: "Add new task", message: "", preferredStyle: .alert)
//            alertController.addTextField { (textField) -> Void in
//                searchTextField = textField
//                searchTextField?.delegate = self //REQUIRED
//                searchTextField?.placeholder = "Enter your task"
//            }
            alertController.addTextField { (textField : UITextField!) -> Void in
                textField.placeholder = "Enter new task"
            }
            let saveAction = UIAlertAction(title: "Add", style: .default, handler: { alert -> Void in
                let textField = alertController.textFields![0] as UITextField
                self.todoList.append(textField.text!)
                self.tableView.reloadData()
            })

            let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil )

            alertController.addAction(saveAction)
            alertController.addAction(cancelAction)

            self.present(alertController, animated: true, completion: nil)
            
        case .leaderboard, .upcomingAppointment, .dailyChallenge, .staffFeed:
            print("")
        
        }
    }
}
