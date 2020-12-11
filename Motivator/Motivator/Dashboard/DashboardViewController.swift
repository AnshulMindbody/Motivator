//
//  DashboardViewController.swift
//  Motivator
//
//  Created by Anshul Jain on 10/12/20.
//

import UIKit
import Charts
import Segmentio
import SwiftEntryKit


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
    var dashboardType: DashboardType = .leaderboard
    var sections: [DashboardType] = DashboardType.allCases
    var content = [SegmentioItem]()
    
    let players = ["Leo", "Ruchi", "Anshul"]
    let goals = [10, 20, 70]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Dashboard"
        loadWelcomeMessage()
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
            let cell = UITableViewCell(style: .value1, reuseIdentifier: "todoListCell")
            cell.textLabel?.numberOfLines = 0
            cell.textLabel?.text = dashBoardList[indexPath.row]
            return cell            
      
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
            showToDoListAlert()
        case .dailyChallenge:
            showDailyChallenge()
        case .leaderboard, .upcomingAppointment, .staffFeed:
            print("")
        
        }
    }
    
    func showToDoListAlert(){
        print("to do clicked")
        let alertController = UIAlertController(title: "Add new task", message: "", preferredStyle: .alert)
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
    }
    
    func showDailyChallenge(){
//        print("to do clicked")
//        let alertController = UIAlertController(title: "Add new challenge", message: "", preferredStyle: .alert)
//        
//        alertController.addTextField { (textField : UITextField!) -> Void in
//            textField.placeholder = "Staff ID"
//        }
//        
//        alertController.addTextField { (textField : UITextField!) -> Void in
//            textField.placeholder = "Enter new challenge"
//        }
//        let saveAction = UIAlertAction(title: "Add", style: .default, handler: { alert -> Void in
//            if let textFieldID = alertController.textFields?[0] as? UITextField,
//               let textFielChallenge = alertController.textFields?[1] as? UITextField,
//               let staffID = textFieldID.text?.isEmpty,
//               let staffName = textFielChallenge.text?.isEmpty else {
//          //  self.todoList.append(textField.text!)
//            self.tableView.reloadData()
//            }
//        })
//
//        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil )
//
//        alertController.addAction(saveAction)
//        alertController.addAction(cancelAction)
//
//        self.present(alertController, animated: true, completion: nil)
    }

    
    func loadWelcomeMessage(){
        // Generate top floating entry and set some properties
        var attributes = EKAttributes.topFloat
        attributes.entryBackground = .gradient(gradient: .init(colors: [EKColor(.red), EKColor(.green)], startPoint: .zero, endPoint: CGPoint(x: 1, y: 1)))
        attributes.popBehavior = .animated(animation: .init(translate: .init(duration: 0.3), scale: .init(from: 1, to: 0.7, duration: 0.7)))
        attributes.shadow = .active(with: .init(color: .black, opacity: 0.5, radius: 10, offset: .zero))
        attributes.statusBar = .dark
        attributes.scroll = .enabled(swipeable: true, pullbackAnimation: .jolt)
        attributes.positionConstraints.maxSize = .init(width: .constant(value: UIScreen.main.bounds.width), height: .intrinsic)
        attributes.position = .center

        let title = EKProperty.LabelContent(text: "Welcome User", style: .init(font: UIFont.boldSystemFont(ofSize: 17), color: .black))
        let description = EKProperty.LabelContent(text: "Check the latest updates here!!!", style: .init(font: UIFont.systemFont(ofSize: 14.0), color: .black))
//        let image = EKProperty.ImageContent(image: UIImage(named: imageName)!, size: CGSize(width: 35, height: 35))
        let simpleMessage = EKSimpleMessage(image: nil, title: title, description: description)
        let notificationMessage = EKNotificationMessage(simpleMessage: simpleMessage)

        let contentView = EKNotificationMessageView(with: notificationMessage)
        SwiftEntryKit.display(entry: contentView, using: attributes)

    }
}
