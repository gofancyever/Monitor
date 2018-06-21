//
//  WindStatisticsCell.swift
//  Monitor
//
//  Created by gaof on 2018/5/29.
//  Copyright © 2018年 gaof. All rights reserved.
//

import UIKit
import Reusable
import IBAnimatable
import Charts
private class CubicLineSampleFillFormatter: IFillFormatter {
    func getFillLinePosition(dataSet: ILineChartDataSet, dataProvider: LineChartDataProvider) -> CGFloat {
        return -10
    }
}
class WindStatisticsCell: BaseStatisticsCell, NibReusable {
//    @IBOutlet weak var chartView: BaseLineChartView!
    override func awakeFromNib() {
        super.awakeFromNib()
        if let chartView = chartView as? BaseLineChartView {
            chartView.delegate = self
            chartView.maxHighlightDistance = 300
            chartView.showWarningLine = true
            chartView.warningLineLabel = "警戒风速"
            chartView.warningLineLimit = 50
        }
        
        self.setDataCount(Int(20 + 1), range: UInt32(100))
        
        chartView.animate(xAxisDuration: 2, yAxisDuration: 2)
    }
    func setDataCount(_ count: Int, range: UInt32) {
        let yVals1 = (0..<count).map { (i) -> ChartDataEntry in
            let mult = range + 1
            let val = Double(arc4random_uniform(mult) + 20)
            return ChartDataEntry(x: Double(i), y: val)
        }
        let yVals2 = (0..<count).map { (i) -> ChartDataEntry in
            let mult = range + 1
            let val = Double(arc4random_uniform(mult) + 20)
            return ChartDataEntry(x: Double(count+i), y: val)
        }
        
        let set1 = LineChartDataSet(values: yVals1, label: "实际风速")

        set1.colors = [UIColor(red:0.46, green:0.95, blue:0.69, alpha:1.00)]
        set1.mode = .cubicBezier
        set1.drawFilledEnabled = true
        set1.mode = .cubicBezier
        //填充颜色
        set1.fillColor = UIColor(red:0.46, green:0.95, blue:0.69, alpha:1.00)
        set1.fillAlpha = 1
        set1.drawCirclesEnabled = true
        set1.lineWidth = 1.8
        set1.circleRadius = 4
        set1.setCircleColor(.white)
        set1.highlightColor = UIColor(red: 244/255, green: 117/255, blue: 117/255, alpha: 1)
        set1.drawHorizontalHighlightIndicatorEnabled = false
        set1.fillFormatter = CubicLineSampleFillFormatter()
        
        // 预测数据属性
        let set2 = LineChartDataSet(values: yVals2, label: "未来风速")
        
        set2.colors = [#colorLiteral(red: 0.7254902124, green: 0.4784313738, blue: 0.09803921729, alpha: 1)]
        set2.mode = .cubicBezier
        set2.drawFilledEnabled = true
        set2.fillColor = #colorLiteral(red: 0.7254902124, green: 0.4784313738, blue: 0.09803921729, alpha: 1)
        set2.fillAlpha = 1
        set2.drawCirclesEnabled = true
        set2.lineWidth = 1.8
        set2.circleRadius = 4
        set2.setCircleColor(.white)
        set2.drawHorizontalHighlightIndicatorEnabled = false
        set2.fillFormatter = CubicLineSampleFillFormatter()
        
        let data = LineChartData(dataSets: [set1,set2])
        
        
        data.setValueFont(UIFont(name: "HelveticaNeue-Light", size: 9)!)
        data.setDrawValues(false)
        
        chartView.data = data
        set1.drawValuesEnabled = true
        set2.drawValuesEnabled = true
        chartView.animate(xAxisDuration: 3, yAxisDuration: 3)
        chartView.setNeedsDisplay()
    }

}
extension WindStatisticsCell:ChartViewDelegate {
    
}
