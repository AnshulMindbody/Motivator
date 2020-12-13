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
import JGProgressHUD
import Alamofire


protocol DashboardViewType {
    var type:DashboardType { get set}
    var name: String { get set}

}

struct LeaderBaord: DashboardViewType {
    var type: DashboardType = .leaderboard
    let score: String
    let level: String
    var name: String
    var image: UIImage
}

struct UpcomingAppointments: DashboardViewType {
    var type: DashboardType = .upcomingAppointment
    var name: String
}

struct ToDo: DashboardViewType {
    var type: DashboardType = .todoList
    var name: String
    let completed: Bool = false
}

struct DailyChallenge: DashboardViewType {
    var type: DashboardType = .dailyChallenge
    var name: String
    var accepted = false
    var completed = false
    var rejected = false
}

enum DashboardType:String, CaseIterable{
    case leaderboard = "Leaderboard"
    case upcomingAppointment = "Upcoming Appointment"
    case dailyChallenge = "Todo List"
    case todoList = "Staff Feed"
}


final class DashboardViewController: UIViewController {
    
  
    @IBOutlet var pieChartView: PieChartView!
    @IBOutlet var scoreLabel: UILabel!
    
    @IBOutlet var tableView: UITableView! {
        didSet {
            tableView.tableFooterView = UIView()
            tableView.register(UINib(nibName: "LeaderboardTableViewCell", bundle: nil), forCellReuseIdentifier: "LeaderboardTableViewCell")
            tableView.register(UINib(nibName: "UpcomingAppointmentTableViewCell", bundle: nil), forCellReuseIdentifier: "UpcomingAppointmentTableViewCell")
            tableView.register(UINib(nibName: "DailyChallengeTableViewCell", bundle: nil), forCellReuseIdentifier: "DailyChallengeTableViewCell")
            tableView.register(UINib(nibName: "TodoListTableViewCell", bundle: nil), forCellReuseIdentifier: "TodoListTableViewCell")
        }
    }
    @IBOutlet var userRatingProfileView: UIView! {
        didSet {
            userRatingProfileView.layer.cornerRadius = 10.0
            userRatingProfileView.addShadow()
        }
    }
    @IBOutlet var segmentioView: Segmentio!
    @IBOutlet var floatingButton: UIButton!
    @IBOutlet var textField: UITextField!{
        didSet{
            textField.delegate = self
            textField.layer.cornerRadius = 10.0
            textField.addShadow()
        }
    }
    
    let manager = SocketManager(socketURL: URL(string: "http://localhost:3001")!, config: [.log(true), .compress, .connectParams(["username": "Anshulsd jain"])])
    
    var dashBoardList: [DashboardViewType] {
        switch dashboardType{
        case .leaderboard:
            floatingButton.isHidden = true
            return [
                LeaderBaord(score: "130", level:"30", name: "Leo",image: UIImage(named: "profile1")!),
                LeaderBaord(score:  "129", level:"29", name: "Anette",image: UIImage(named: "profile2")!),
                LeaderBaord(score: "128", level:"28", name: "Ravi",image: UIImage(named: "profile3")!)
            ]
        case .upcomingAppointment:
            floatingButton.isHidden = true
            return [
                UpcomingAppointments(name: "Hair styling - Mrs. Maureen  at 10.00am"),
                UpcomingAppointments(name: "Manipure & Pedicure - Ms. Simon Sais at 11.30pm"),
                UpcomingAppointments(name: "Head massage - Ms. Elly at 01.30pm"),
                UpcomingAppointments(name: "Facial - Ms. Stanley Knife at 3:00pm"),
                UpcomingAppointments(name: "Keratin treatment - Mrs. Emma Grate at 5:00pm")
            ]
        case .dailyChallenge:
            floatingButton.isHidden = false
            return dailyChallenge
        case .todoList:
            floatingButton.isHidden = false
            return todoList
        }
    }
    
    var todoList: [ToDo] = [
        ToDo(name: "Complete 5 services."),
        ToDo(name: "Clean your service station after every service."),
        ToDo(name: "Sell at least 2 products."),
        ToDo(name: "Upsell at least 2 services.")
    ]
    var todoCompletedFlagList: [Bool] = [true, false, false, true]
    
    var staffFeedList = [
        "Stan Dupp posted 2 hours ago - I have made a sell of 5 products today.",
        "Mark Ateer posted 4 hours ago - Feelings fresh on a Monday morning,"
    ]
    
    var dailyChallenge = [
        
        DailyChallenge(name: "You have been challenged by Pat Thettick to sell 3 products.", accepted: true, completed: false, rejected: false),
        DailyChallenge(name: "Accepting the challenge will earn you 5 points and completing it will earn you 20 points."),
        DailyChallenge(name: "Stan Dupp has accepted your challenge and that earned him 5 points."),
        DailyChallenge(name: "You challenged Stan Dupp to complete 6 services.")
    ]
    
    var rankImages = ["rank1", "rank2", "rank3"]
    
    var dashboardType: DashboardType = .leaderboard
    var sections: [DashboardType] = DashboardType.allCases
    var content = [SegmentioItem]()
    
    let players = ["Challenges", "ToDo Tasks"]
    let goals = [55, 45]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Dashboard"
        // loadWelcomeMessage()
        allowHidingKeyboard()
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
        
        case .dailyChallenge:
            let cell = tableView.dequeueReusableCell(withIdentifier: "DailyChallengeTableViewCell") as! DailyChallengeTableViewCell//UITableViewCell(style: .value1, reuseIdentifier: "LeaderboardTableViewCell") as! LeaderboardTableViewCell
            let dailyChallenge = dashBoardList[indexPath.row] as! DailyChallenge
            cell.configure(model: dailyChallenge)
            return cell
        case .leaderboard:
            let cell = tableView.dequeueReusableCell(withIdentifier: "LeaderboardTableViewCell") as! LeaderboardTableViewCell//UITableViewCell(style: .value1, reuseIdentifier: "LeaderboardTableViewCell") as! LeaderboardTableViewCell
            let leaderBaordModel = dashBoardList[indexPath.row] as! LeaderBaord
            cell.nameLabel?.numberOfLines = 0
            cell.nameLabel?.text = leaderBaordModel.name
            cell.scoreLabel?.text = leaderBaordModel.score
            cell.levelLabel?.text = leaderBaordModel.level
            cell.profileImageview.image = leaderBaordModel.image
            return cell
        case .upcomingAppointment:
            let cell = tableView.dequeueReusableCell(withIdentifier: "UpcomingAppointmentTableViewCell") as! UpcomingAppointmentTableViewCell
            let upcomingAppointments = dashBoardList[indexPath.row] as! UpcomingAppointments
            cell.labelName?.text = upcomingAppointments.name
            return cell
        case .todoList:
            let cell = tableView.dequeueReusableCell(withIdentifier: "TodoListTableViewCell") as! TodoListTableViewCell
            let todoModel = dashBoardList[indexPath.row] as! ToDo
            cell.labelName?.text = todoModel.name
            cell.accessoryType = todoModel.completed ? .checkmark : .none
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dashBoardList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch dashboardType {
        case .leaderboard:
            return 100
        case .upcomingAppointment:
            return 100
        case .dailyChallenge:
            return 100
        case .todoList:
            return 100
        }
    }
    
}

extension DashboardViewController {
    
    func loadPieChart(){
                pieChartView.drawHoleEnabled = true
        customizeChart(dataPoints: players, values: goals.map{ Double($0) })
        pieChartView.legend.enabled = true
        pieChartView.legend.direction = .rightToLeft
        pieChartView.drawEntryLabelsEnabled = false
        pieChartView.drawCenterTextEnabled = false

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
        pieChartDataSet.drawValuesEnabled = false
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
        for i in 0..<numbersOfColor {
            if i == 0 {
            let color = UIColor.orange
            colors.append(color)
            } else if i == 1 {
                let color = UIColor.systemBlue
                colors.append(color)
            }
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
            )
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
        case .leaderboard, .upcomingAppointment:
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
                self.dailyChallenge.insert(DailyChallenge(name: message, accepted: true), at: 0)
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
                self.dailyChallenge.remove(at: 0)
                self.dailyChallenge.insert(DailyChallenge(name: ("You challenge " + textField.text!), accepted: true), at: 0)
                tableView.reloadData()
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
        attributes.entryBackground = .color(color: EKColor(red: 238, green: 137, blue: 0))
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
        let alertController = UIAlertController(title: "Add new task", message: "", preferredStyle: .alert)
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "Enter new task"
        }
        let saveAction = UIAlertAction(title: "Add", style: .default, handler: { alert -> Void in
            let textField = alertController.textFields![0] as UITextField
            self.todoList.append(ToDo(name: textField.text!))
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
            self.scoreLabel?.text =  String(Int(self.scoreLabel.text!)! + 25)

        }
        
        let rejectAction = UIAlertAction(title: "Reject", style: .default) { _ in
            self.manager.defaultSocket.emit("challengeAccepted", "OK")
        }
        
        let cancelAction = UIAlertAction(title: "Later", style: .default, handler: nil )
        
        alertController.addAction(saveAction)
        alertController.addAction(rejectAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    func addDailyChallenge(){
        print("to do clicked")
        let alertController = UIAlertController(title: "Add new challenge", message: "", preferredStyle: .alert)
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "Tag your colleague"
        }
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "Enter new challenge"
        }
        
        let saveAction = UIAlertAction(title: "Challenge", style: .default, handler: { alert -> Void in
            let textField = alertController.textFields![1] as UITextField
            self.dailyChallenge.insert(DailyChallenge(name: ("You challenge " + textField.text!)), at: 0)
            self.tableView.reloadData()
            self.manager.defaultSocket.emit("challenge", textField.text!)
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


extension UIView {
func addShadow(shadowColor: CGColor = UIColor.black.cgColor,
                   shadowOffset: CGSize = CGSize(width: 1.0, height: 2.0),
                   shadowOpacity: Float = 0.4,
                   shadowRadius: CGFloat = 3.0) {
        layer.shadowColor = shadowColor
        layer.shadowOffset = shadowOffset
        layer.shadowOpacity = shadowOpacity
        layer.shadowRadius = shadowRadius
        layer.masksToBounds = false
    }
}


class TextField: UITextField {

    let padding = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)

    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
}


extension UIViewController {

    func allowHidingKeyboard() {
        let tap = UITapGestureRecognizer(target: self,
                                         action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension DashboardViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        let login = StaffComment(name: "Anshul", comment: textField.text!)
        let hud = JGProgressHUD()
        hud.show(in: self.view)
        AF.request("http://localhost:3000/staff",
                   method: .post,
                   parameters: login,
                   encoder: JSONParameterEncoder.default).response { response in

                    DispatchQueue.main.async { [self] in
                        hud.dismiss()
                        textField.text = ""
                        showAnimatedAltert(message: "Staus shared succesfully!!!")
                    }
        }
        
        return true
    }

}
