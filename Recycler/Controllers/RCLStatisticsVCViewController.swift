//
//  RCLStatisticsVCViewController.swift
//  Recycler
//
//  Created by Володимир Смульський on 3/15/18.
//  Copyright © 2018 softserve.university. All rights reserved.

import UIKit
import Charts

class RCLStatisticsVCViewController: UIViewController {

    @IBOutlet weak var lineChartView: LineChartView!
    
    var daysInWeek = 7
    func date() -> [Double] {
        
        let date = Date()
        var components = DateComponents()
        let calendar = Calendar.current
        components.year = calendar.component(.year, from: date)
        components.month = calendar.component(.month, from: date)
        components.day = calendar.component(.day, from: date) - 1
        components.hour = 0
        components.minute = 0
        components.second = 0
        let newDate = calendar.date(from: components)
        print("Date  \(newDate!)!!!!!!!!!")
        FirestoreService.shared.getTrashBy(oneDay: newDate!) { trashList in
            print(trashList.count)
        }
        
        for i  in 0..<daysInWeek {
            components.day = calendar.component(.day, from: date) + i
            FirestoreService.shared.getTrashBy(oneDay: newDate! + TimeInterval(i)) { trashList in
                //print(trashList.count)
                self.numbersForGlass += [Double(trashList.count)]
            }
        }
        return numbersForGlass
    }
    
    var testArray  :[Double] = []
    var numbersForGlass : [Double] = [9,3,5,12,24,16,9]
    var numbersForBatteries : [Double] = [1,5,10,6,14,10,11]
    var numbersForOrganic : [Double] = [2,3,8,2,4,12,21]
    var numbersForPlastic: [Double] = [3,4,9,2,9,17,13]
    var numbersForPaper :   [Double] = [7,10,15,2,10,11,15]
    var numbersForMetal :   [Double] = [13,4,0,2,1,25,20]
    //print("DAY 1 =", numbersForGlass)
    override func viewDidLoad() {
        super.viewDidLoad()
         numbersForGlass = date()
        print(numbersForGlass)
    
//        self.navigationItem.backBarButtonItem = UIBarButtonItem(title:"n", style:.plain, target:nil, action:nil)
        updateGraph()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
    self.navigationController?.navigationBar.isHidden = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    self.navigationController?.navigationBar.isHidden = false
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateGraph(){
        //Array that will be displayed on the graph.
        var lineChartEntryPlastic = [ChartDataEntry]()
        var lineChartEntryPaper   = [ChartDataEntry]()
        var lineChartEntryMetal   = [ChartDataEntry]()
        var lineChartEntryBatteries = [ChartDataEntry]()
        var lineChartEntryOrganic = [ChartDataEntry]()
        var lineChartEntryGlass = [ChartDataEntry]()
        
        for i in 0..<daysInWeek {
            //set the X and Y status in a data chart entry
            let valueForPlastic = ChartDataEntry(x: Double(i), y: numbersForPlastic[i])
            let valueForPaper   = ChartDataEntry(x: Double(i), y: numbersForPaper  [i])
            let valueForMetal   = ChartDataEntry(x: Double(i), y: numbersForMetal  [i])
            let valueForGlass   = ChartDataEntry(x: Double(i), y: numbersForGlass  [i])
            let valueForBatteries   = ChartDataEntry(x: Double(i), y: numbersForBatteries  [i])
            let valueForOrganic   = ChartDataEntry(x: Double(i), y: numbersForOrganic  [i])
            
            // here we add it to the data set
            lineChartEntryPlastic.append(valueForPlastic)
            lineChartEntryPaper.append(valueForPaper)
            lineChartEntryMetal.append(valueForMetal)
            lineChartEntryBatteries.append(valueForBatteries)
            lineChartEntryGlass.append(valueForGlass)
            lineChartEntryOrganic.append(valueForOrganic)
        }
        
        //Here we convert lineChartEntry to a LineChartDataSet
        let line1 = LineChartDataSet(values: lineChartEntryPlastic, label: "Plastic")
        let line2 = LineChartDataSet(values: lineChartEntryPaper, label: "Paper")
        let line3 = LineChartDataSet(values: lineChartEntryMetal, label: "Metal")
        let line4 = LineChartDataSet(values: lineChartEntryBatteries, label: "Batteries")
        let line5 = LineChartDataSet(values: lineChartEntryGlass, label: "Glass")
        let line6 = LineChartDataSet(values: lineChartEntryOrganic, label: "Organic")
        //Sets the colours
        line1.colors = [NSUIColor.blue]
        line2.colors = [NSUIColor.yellow]
        line3.colors = [NSUIColor.red]
        line4.colors = [NSUIColor.cyan]
        line5.colors = [NSUIColor.black]
        line6.colors = [NSUIColor.darkGray]
        
        line1.valueTextColor = UIColor.blue
        line2.valueTextColor = NSUIColor.yellow
        line3.valueTextColor = NSUIColor.red
        line4.valueTextColor = NSUIColor.cyan
        line5.valueTextColor = NSUIColor.black
        line6.valueTextColor = NSUIColor.darkGray
        
        //This is the object that will be added to the chart
        let data = LineChartData()
        
        data.addDataSet(line1) //Adds the line to the dataSet
        data.addDataSet(line2)
        data.addDataSet(line3)
        data.addDataSet(line4)
        data.addDataSet(line5)
        data.addDataSet(line6)
        
        //it adds the chart data to the chart and causes an update
        lineChartView.data = data
    }
}
