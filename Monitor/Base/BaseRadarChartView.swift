//
//  BaseRadarChartView.swift
//  Monitor
//
//  Created by gaof on 2018/6/12.
//  Copyright © 2018年 gaof. All rights reserved.
//

import Charts

class BaseRadarChartView: RadarChartView {

    var activities:[String] = ["钾", "氮", "磷"]
    public override init(frame: CGRect)
    {
        super.init(frame: frame)
        config()
    }
    
    public required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        config()
    }
    func config() {
        self.chartDescription?.enabled = false
        self.webLineWidth = 1
        self.innerWebLineWidth = 1
        self.webColor = .lightGray
        self.innerWebColor = .lightGray
        self.webAlpha = 1
        
        let xAxis = self.xAxis
        xAxis.labelFont = .systemFont(ofSize: 9, weight: .light)
        xAxis.xOffset = 0
        xAxis.yOffset = 0
        xAxis.valueFormatter = self
        xAxis.labelTextColor = .black
        
        let yAxis = self.yAxis
        yAxis.labelFont = .systemFont(ofSize: 9, weight: .light)
        yAxis.labelCount = 5
        yAxis.axisMinimum = 0
        yAxis.axisMaximum = 80
        yAxis.drawLabelsEnabled = false
        
        let l = self.legend
        l.horizontalAlignment = .center
        l.verticalAlignment = .top
        l.orientation = .horizontal
        l.drawInside = false
        l.font = .systemFont(ofSize: 10, weight: .light)
        l.xEntrySpace = 7
        l.yEntrySpace = 5
        l.textColor = .black

        
    }
}
extension BaseRadarChartView: IAxisValueFormatter {
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        return activities[Int(value) % activities.count]
    }
}
