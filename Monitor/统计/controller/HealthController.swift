//
//  HealthController.swift
//  Monitor
//
//  Created by gaof on 2018/5/28.
//  Copyright © 2018年 gaof. All rights reserved.
//

import UIKit
import Charts

class HealthController: UIViewController {

    @IBOutlet weak var chartView: BaseRadarChartView!

    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.setChartData()
        chartView.animate(xAxisDuration: 1.4, yAxisDuration: 1.4, easingOption: .easeOutBack)
    }


    func setChartData() {
        let mult: UInt32 = 80
        let min: UInt32 = 20
        let cnt = 3
        
        let block: (Int) -> RadarChartDataEntry = { _ in return RadarChartDataEntry(value: Double(arc4random_uniform(mult) + min))}
        let entries1 = (0..<cnt).map(block)
        let entries2 = (0..<cnt).map(block)
        
        let set1 = RadarChartDataSet(values: entries1, label: "标准")
        set1.setColor(UIColor(red: 103/255, green: 110/255, blue: 129/255, alpha: 1))
        set1.fillColor = UIColor(red: 103/255, green: 110/255, blue: 129/255, alpha: 1)
        set1.drawFilledEnabled = true
        set1.fillAlpha = 0.7
        set1.lineWidth = 2
        set1.drawHighlightCircleEnabled = true
        set1.setDrawHighlightIndicators(false)
        
        let set2 = RadarChartDataSet(values: entries2, label: "当前")
        set2.setColor(UIColor(red: 121/255, green: 162/255, blue: 175/255, alpha: 1))
        set2.fillColor = UIColor(red: 121/255, green: 162/255, blue: 175/255, alpha: 1)
        set2.drawFilledEnabled = true
        set2.fillAlpha = 0.7
        set2.lineWidth = 2
        set2.drawHighlightCircleEnabled = true
        set2.setDrawHighlightIndicators(false)
        
        let data = RadarChartData(dataSets: [set1, set2])
        data.setValueFont(.systemFont(ofSize: 8, weight: .light))
        data.setDrawValues(false)
        data.setValueTextColor(.black)
        
        chartView.data = data
    }
    
    


}
