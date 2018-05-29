//
//  HumidityCell.swift
//  Monitor
//
//  Created by gaof on 2018/5/29.
//  Copyright © 2018年 gaof. All rights reserved.
//

import UIKit
import Reusable
import Charts
class HumidityCell: UICollectionViewCell,NibReusable {
    @IBOutlet var chartView: BarChartView!
    override func awakeFromNib() {
        super.awakeFromNib()
    
//        chartView.delegate = self
        
        chartView.chartDescription?.enabled = false
        chartView.maxVisibleCount = 60
        chartView.pinchZoomEnabled = false
        chartView.drawBarShadowEnabled = false
        
        let xAxis = chartView.xAxis
        xAxis.labelPosition = .bottom
        
        chartView.legend.enabled = false
        
        self.setDataCount(10, range: Double(100))
    }
    
    func setDataCount(_ count: Int, range: Double) {
        let yVals = (0..<count).map { (i) -> BarChartDataEntry in
            let mult = range + 1
            let val = Double(arc4random_uniform(UInt32(mult))) + mult/3
            return BarChartDataEntry(x: Double(i), y: val)
        }
        
        var set1: BarChartDataSet! = nil
        if let set = chartView.data?.dataSets.first as? BarChartDataSet {
            set1 = set
            set1?.values = yVals
            chartView.data?.notifyDataChanged()
            chartView.notifyDataSetChanged()
        } else {
            set1 = BarChartDataSet(values: yVals, label: "Data Set")
            set1.colors = ChartColorTemplates.vordiplom()
            set1.drawValuesEnabled = false
            
            let data = BarChartData(dataSet: set1)
            chartView.data = data
            chartView.fitBars = true
        }
        
        chartView.setNeedsDisplay()
    }
    

}
