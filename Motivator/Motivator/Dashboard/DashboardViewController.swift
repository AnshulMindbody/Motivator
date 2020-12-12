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
import SocketIO

//struct DashBoardModel {
//    let image: UIImage
//    let selected = false
//    let name: String
//    let showSelection = false
//}


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
    @IBOutlet var textFieldSearchBar: UISearchBar!{
        didSet{
            textFieldSearchBar.delegate = self
            textFieldSearchBar.setImage(UIImage(named: "statusIcon.png"), for: .search, state: .normal)
            textFieldSearchBar.returnKeyType = .done
        }
    }
    let manager = SocketManager(socketURL: URL(string: "http://localhost:3000")!, config: [.log(true), .compress, .connectParams(["username": "Anshulsd jain"])])
    
    var dashBoardList: [String] {
        
        switch dashboardType{
        case .leaderboard:
            floatingButton.isHidden = true
            self.tableView.register(UINib(nibName: "LeaderboardTableViewCell", bundle: nil), forCellReuseIdentifier: "LeaderboardTableViewCell")
            return [
                "Neil Down is at Level 27 with 789 score",
                "Allie Grater is at Level 23 with 699 score",
                "Pat Thett is at Level 23 with 600 score",
            ]
        case .upcomingAppointment:
            floatingButton.isHidden = true
            return [
                "Hair styling - Mrs. Maureen  at 10.00am",
                "Manipure & Pedicure - Ms. Simon Sais at 11.30pm",
                "Head massage - Ms. Elly at 01.30pm",
                "Facial - Ms. Stanley Knife at 3:00pm",
                "Keratin treatment - Mrs. Emma Grate at 5:00pm",
            ]
        case .dailyChallenge:
            floatingButton.isHidden = false
            return dailyChallenge
        case .todoList:
            floatingButton.isHidden = false
            return todoList
        case .staffFeed:
            floatingButton.isHidden = true
            return staffFeedList
        }
    }
    
    var todoList: [String] = [
        "Complete 5 services.",
        "Clean your service station after every service.",
        "Sell at least 2 products.",
        "Upsell at least 2 services."
    ]
    var todoCompletedFlagList: [Bool] = [true, false, false, true]
    
    var staffFeedList = [
        "Stan Dupp posted 2 hours ago - I have made a sell of 5 products today.",
        "Mark Ateer posted 4 hours ago - Feelings fresh on a Monday morning,"
    ]
    
    var dailyChallenge = [
        "You have been challenged by Pat Thettick to sell 3 products.",
        "Accepting the challenge will earn you 5 points and completing it will earn you 20 points.",
        "Stan Dupp has accepted your challenge and that earned him 5 points.",
        "You challenged Stan Dupp to complete 6 services.",
    ]
    
    var proofileImages = ["profile1", "profile2", "profile3"]
    var rankImages = ["rank1", "rank2", "rank3"]
    
    var dashboardType: DashboardType = .leaderboard
    var sections: [DashboardType] = DashboardType.allCases
    var content = [SegmentioItem]()
    
    let players = ["Daily Challenges", "To Do"]
    let goals = [55, 45]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Dashboard"
        // loadWelcomeMessage()
        loadSocketConnection()
        loadPieChart()
        loadSlidingTabControl()
    }
    
}

extension DashboardViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if dashboardType == .todoList {
            if let cell = tableView.cellForRow(at: indexPath) {
                cell.accessoryType = todoCompletedFlagList[indexPath.row] ? .none : .checkmark
                todoCompletedFlagList[indexPath.row] = !todoCompletedFlagList[indexPath.row]
            }
        }
        else if dashboardType == .dailyChallenge {
            notifyChallengeAlert(dailyChallenge: "")
        }
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
            let cell = UITableViewCell(style: .value1, reuseIdentifier: "Cell")
            cell.textLabel?.numberOfLines = 0
            cell.textLabel?.text = dashBoardList[indexPath.row]
            cell.accessoryType = todoCompletedFlagList[indexPath.row] ? .checkmark : .none
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
    
    func loadPieChart(){
                pieChartView.drawHoleEnabled = false
        customizeChart(dataPoints: players, values: goals.map{ Double($0) })
        
        //      pieChartView.legend.orientation = .vertical
        //      pieChartView.legend.verticalAlignment = .top
        pieChartView.legend.enabled = false
    }

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
    
    @IBAction func floatingButtonClicked(){
        switch dashboardType {
        case .todoList:
            showToDoListAlert()
        case .dailyChallenge:
            addDailyChallenge()
        case .leaderboard, .upcomingAppointment, .staffFeed:
            print("")
            
        }
    }
    
}

extension DashboardViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        if let searchText = searchBar.text {
            staffFeedList.append(searchText)
            tableView.reloadData()
        }
        searchBar.text = ""
    }
    
}

extension DashboardViewController {
    
    func loadSocketConnection(){
        let socket = manager.defaultSocket
        
        socket.on(clientEvent: .connect) {data, ack in
            print("socket connected")
        }
        
        
        socket.connect()
        
        socket.emit("connectUser", "anshul jain")
        
        
        socket.on("challenge") { [self]data, ack in
            guard let dataDict = data as? [[String: String]] else { return }
            if let username = dataDict[0]["username"],
               let message  = dataDict[0]["message"] {
                let message = (username + " challenged " + message)
                self.dailyChallenge.insert(message, at: 0)
                showDailyChallengeAlert(dailyChallenge: message)
                DispatchQueue.main.async {
                    tableView.reloadData()
                }
            }
            ack.with("Got your currentAmount", "dude")
        }
        
        
        socket.on("challengeAccepted") { [self]data, ack in
            guard let dataDict = data as? [[String: String]] else { return }
            if let username = dataDict[0]["username"],
               let message  = dataDict[0]["message"],
               message == "OK"{
                let message = (username + " Accepted the challenege.")
                // self.dailyChallenge.insert(message, at: 0)
                DispatchQueue.main.async {
                    showAnimatedAltert(message: message)
                }
            }
            ack.with("Got your currentAmount", "dude")
        }
        
        socket.on("challengeValidate") { [self]data, ack in
            guard let dataDict = data as? [[String: String]] else { return }
            if let username = dataDict[0]["username"],
               let message  = dataDict[0]["message"],
               message == "OK"{
                let message = ( "\(username) has completed the challenege.")
                // self.dailyChallenge.insert(message, at: 0)
                DispatchQueue.main.async {
                    showAnimatedAltert(message: message)
                }
            }
            ack.with("Got your currentAmount", "dude")
        }
        
        socket.on("challengeCompleted") { [self]data, ack in
            guard let dataDict = data as? [[String: String]] else { return }
              if let message  = dataDict[0]["message"],
               message == "OK"{
                // self.dailyChallenge.insert(message, at: 0)
                DispatchQueue.main.async {
                    showAnimatedAltert(message: "Your chalenge is validate and it is completed now")
                }
            }
            ack.with("Got your currentAmount", "dude")
        }
        
        
    }
    
}

extension DashboardViewController{
    func showAnimatedAltert(message:String){
        // Generate top floating entry and set some properties
        var attributes = EKAttributes.topFloat
        attributes.entryBackground = .gradient(gradient: .init(colors: [EKColor(.red), EKColor(.green)], startPoint: .zero, endPoint: CGPoint(x: 1, y: 1)))
        attributes.popBehavior = .animated(animation: .init(translate: .init(duration: 0.3), scale: .init(from: 1, to: 0.7, duration: 0.7)))
        attributes.shadow = .active(with: .init(color: .black, opacity: 0.5, radius: 10, offset: .zero))
        attributes.statusBar = .dark
        attributes.scroll = .enabled(swipeable: true, pullbackAnimation: .jolt)
        attributes.positionConstraints.maxSize = .init(width: .constant(value: UIScreen.main.bounds.width), height: .intrinsic)
        attributes.position = .top
        
        let title = EKProperty.LabelContent(text: "Wohoooo..", style: .init(font: UIFont.boldSystemFont(ofSize: 17), color: .black))
        let description = EKProperty.LabelContent(text: message, style: .init(font: UIFont.systemFont(ofSize: 14.0), color: .black))
        //        let image = EKProperty.ImageContent(image: UIImage(named: imageName)!, size: CGSize(width: 35, height: 35))
        let simpleMessage = EKSimpleMessage(image: nil, title: title, description: description)
        let notificationMessage = EKNotificationMessage(simpleMessage: simpleMessage)
        
        let contentView = EKNotificationMessageView(with: notificationMessage)
        SwiftEntryKit.display(entry: contentView, using: attributes)
        
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
            self.todoCompletedFlagList.append(false)
            self.tableView.reloadData()
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil )
        
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    func showDailyChallengeAlert(dailyChallenge: String){
        
        let alertController = UIAlertController(title: "Daily Challenge", message: dailyChallenge, preferredStyle: .alert)
        
        let saveAction = UIAlertAction(title: "Accept", style: .default) { _ in
            self.manager.defaultSocket.emit("challengeAccepted", "OK")
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil )
        
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    func addDailyChallenge(){
        print("to do clicked")
        let alertController = UIAlertController(title: "Add new challenge", message: "", preferredStyle: .alert)
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "Enter new challenge"
        }
        
        let saveAction = UIAlertAction(title: "Add", style: .default, handler: { alert -> Void in
            let textField = alertController.textFields![0] as UITextField
            self.manager.defaultSocket.emit("challenge", textField.text!)
            self.dailyChallenge.insert(("You challenge " + textField.text!), at: 0)
            self.tableView.reloadData()
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil )
        
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    func validateDailyChallengeAlert(dailyChallenge: String){
        
        let alertController = UIAlertController(title: "Validate Challenge", message: dailyChallenge, preferredStyle: .alert)
        
        let saveAction = UIAlertAction(title: "Completed", style: .default) { _ in
            self.manager.defaultSocket.emit("challengeCompleted", "OK")
        }
        
        let cancelAction = UIAlertAction(title: "Deny", style: .default, handler: nil )
        
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    func notifyChallengeAlert(dailyChallenge: String){
        let alertController = UIAlertController(title: "Validate", message: "Challenge is completed", preferredStyle: .alert)
        
        let saveAction = UIAlertAction(title: "Validated", style: .default) { _ in
            self.manager.defaultSocket.emit("challengeCompleted", "OK")
        }
        
        let cancelAction = UIAlertAction(title: "Deny", style: .default, handler: nil )
        
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
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
