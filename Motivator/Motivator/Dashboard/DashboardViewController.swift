//
//  DashboardViewController.swift
//  Motivator
//
//  Created by Anshul Jain on 10/12/20.
//

import UIKit
import Charts
import Segmentio

final class DashboardViewController: UIViewController {
    
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
    
    var dashBoardList: [String]{
        
        switch dashboardType{
        case .leaderboard:
            floatingButton.isHidden = true
         return [
            "jkgdgf lkgfkd fgdofgfg fghjfdg gfd fgdl gfdhgfd",
            "jkgdgf lkgfkd fgdofgfg fghjfdg gfd fgdl gfdhgfd",
            "jkgdgf lkgfkd fgdofgfg fghjfdg gfd fgdl gfdhgfd",
            "jkgdgf lkgfkd fgdofgfg fghjfdg gfd fgdl gfdhgfd",
            "jkgdgf lkgfkd fgdofgfg fghjfdg gfd fgdl gfdhgfd",
            "jkgdgf lkgfkd fgdofgfg fghjfdg gfd fgdl gfdhgfd",
            "jkgdgf lkgfkd fgdofgfg fghjfdg gfd fgdl gfdhgfd",
            "jkgdgf lkgfkd fgdofgfg fghjfdg gfd fgdl gfdhgfd"
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
            return [
               "todoList todoList todoList todoList",
                "todoList todoList todoList todoList",
                "todoList todoList todoList todoList",
                "todoList todoList todoList todoList",
                "todoList todoList todoList todoList",
                "todoList todoList todoList todoList",
                "todoList todoList todoList todoList",
                "todoList todoList todoList todoList",
                "todoList todoList todoList todoList",
                "todoList todoList todoList todoList",
                "todoList todoList todoList todoList"
               ]
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
        
        case .leaderboard, .upcomingAppointment, .dailyChallenge, .staffFeed:
            let cell = UITableViewCell(style: .value1, reuseIdentifier: "Cell")
            cell.textLabel?.numberOfLines = 0
            cell.textLabel?.text = dashBoardList[indexPath.row]
            return cell
  
        case .todoList:
            
            
      
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dashBoardList.count
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
            print("to to clicked)
        case .default: ()
            
        }
    }
}
