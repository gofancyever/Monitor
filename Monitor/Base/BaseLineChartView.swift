//
//  BaseLineChartView.swift
//  Monitor
//
//  Created by gaof on 2018/6/12.
//  Copyright © 2018年 gaof. All rights reserved.
//

import Charts

@IBDesignable
class BaseLineChartView: LineChartView {
    
    /// 是否显示警戒线
    @IBInspectable var showWarningLine:Bool = false {
        didSet {
            if showWarningLine {
                self.leftAxis.addLimitLine(self.warningLine)
            }else{
                self.leftAxis.removeLimitLine(self.warningLine)
            }
        }
    }
    @IBInspectable var warningLineLabel:String? {
        didSet {
            if let warningLineLabel = warningLineLabel {
                self.warningLine.label = warningLineLabel
            }
        }
    }
    
    @IBInspectable var warningLineLimit:Double = 0 {
        didSet {
            self.warningLine.limit = warningLineLimit
        }
    }
    
    lazy var warningLine:ChartLimitLine = {
        let ll1 = ChartLimitLine(limit: 150)
        ll1.lineWidth = 2
        ll1.lineDashLengths = [5, 5]
        ll1.labelPosition = .rightTop
        ll1.valueFont = .systemFont(ofSize: 10)
        return ll1
    }()
    
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
        self.setViewPortOffsets(left: 20, top: 20, right: 20, bottom: 40)
        self.backgroundColor = UIColor.white
        self.dragEnabled = true
        self.setScaleEnabled(true)
        self.pinchZoomEnabled = false
        self.legend.enabled = true
        let yAxis = self.leftAxis
        yAxis.labelFont = UIFont(name: "HelveticaNeue-Light", size:12)!
        yAxis.setLabelCount(6, force: false)
        yAxis.labelTextColor = .black
        yAxis.labelPosition = .outsideChart
        yAxis.axisLineColor = .white
        yAxis.axisMaximum = 200
        self.rightAxis.enabled = false
        
        
        let xAxis = self.xAxis
        xAxis.labelPosition = .bottom
        xAxis.labelFont = .systemFont(ofSize: 10)
        xAxis.granularity = 1
        xAxis.labelCount = 7
        xAxis.valueFormatter = DayAxisValueFormatter(chart: self)
    }
}
