//
//  DashboardViewController.swift
//  Motivator
//
//  Created by Anshul Jain on 10/12/20.
//

import UIKit
import Charts
import Segmentio

class DashboardViewController: UIViewController {
    
    @IBOutlet var pieChartView: PieChartView!
    let players = ["Ozil", "Ramsey", "Laca"]
    let goals = [6, 8, 26]
    @IBOutlet weak var segmentioView: Segmentio!


    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Dashboard"
        pieChartView.drawHoleEnabled = false
        customizeChart(dataPoints: players, values: goals.map{ Double($0) })

        // Do any additional setup after loading the view.
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
        
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
