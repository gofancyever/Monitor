//: Playground - noun: a place where people can play

import UIKit
import Charts
import PlaygroundSupport
import SnapKit
public class DayAxisValueFormatter: NSObject, IAxisValueFormatter {
    weak var chart: BarLineChartViewBase?
    let months = ["Jan", "Feb", "Mar",
                  "Apr", "May", "Jun",
                  "Jul", "Aug", "Sep",
                  "Oct", "Nov", "Dec"]
    
    init(chart: BarLineChartViewBase) {
        self.chart = chart
    }
    
    public func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        let days = Int(value)
        let year = determineYear(forDays: days)
        let month = determineMonth(forDayOfYear: days)
        
        let monthName = months[month % months.count]
        let yearName = "\(year)"
        
        if let chart = chart,
            chart.visibleXRange > 30 * 6 {
            return monthName + yearName
        } else {
            let dayOfMonth = determineDayOfMonth(forDays: days, month: month + 12 * (year - 2016))
            var appendix: String
            
            switch dayOfMonth {
            case 1, 21, 31: appendix = "st"
            case 2, 22: appendix = "nd"
            case 3, 23: appendix = "rd"
            default: appendix = "th"
            }
            
            return dayOfMonth == 0 ? "" : String(format: "%d\(appendix) \(monthName)", dayOfMonth)
        }
    }
    
    private func days(forMonth month: Int, year: Int) -> Int {
        // month is 0-based
        switch month {
        case 1:
            var is29Feb = false
            if year < 1582 {
                is29Feb = (year < 1 ? year + 1 : year) % 4 == 0
            } else if year > 1582 {
                is29Feb = year % 4 == 0 && (year % 100 != 0 || year % 400 == 0)
            }
            
            return is29Feb ? 29 : 28
            
        case 3, 5, 8, 10:
            return 30
            
        default:
            return 31
        }
    }
    
    private func determineMonth(forDayOfYear dayOfYear: Int) -> Int {
        var month = -1
        var days = 0
        
        while days < dayOfYear {
            month += 1
            if month >= 12 {
                month = 0
            }
            
            let year = determineYear(forDays: days)
            days += self.days(forMonth: month, year: year)
        }
        
        return max(month, 0)
    }
    
    private func determineDayOfMonth(forDays days: Int, month: Int) -> Int {
        var count = 0
        var daysForMonth = 0
        
        while count < month {
            let year = determineYear(forDays: days)
            daysForMonth += self.days(forMonth: count % 12, year: year)
            count += 1
        }
        
        return days - daysForMonth
    }
    
    private func determineYear(forDays days: Int) -> Int {
        switch days {
        case ...366: return 2016
        case 367...730: return 2017
        case 731...1094: return 2018
        case 1095...1458: return 2019
        default: return 2020
        }
    }
}


private class CubicLineSampleFillFormatter: IFillFormatter {
    func getFillLinePosition(dataSet: ILineChartDataSet, dataProvider: LineChartDataProvider) -> CGFloat {
        return -10
    }
}

class BaseLineChartView: LineChartView {
    
    /// 是否显示警戒线
    var showWarningLine:Bool = false
    var warningLineLabel:String?
    var warningLineLimit:Double = 0
    
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
        
        if showWarningLine {
            self.leftAxis.addLimitLine(self.warningLine)
            if let warningLabel = self.warningLineLabel {
                self.warningLine.label = warningLabel
            }
            self.warningLine.limit = self.warningLineLimit
        }
    }
}

class ChartController:UIViewController,ChartViewDelegate {
    var lineChartView: LineChartView = BaseLineChartView()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        view.addSubview(lineChartView)
        lineChartView.snp.makeConstraints { (make) in
            make.left.equalTo(view).offset(20)
            make.right.equalTo(view).offset(-20)
            make.height.equalTo(200)
            make.top.equalTo(view)
        }
        lineChartView.delegate = self
        lineChartView.maxHighlightDistance = 300
        
        
        self.setDataCount(Int(20 + 1), range: UInt32(100))
        
        lineChartView.animate(xAxisDuration: 2, yAxisDuration: 2)
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
        set1.valueTextColor = #colorLiteral(red: 0.06274510175, green: 0, blue: 0.1921568662, alpha: 1)
        set1.mode = .cubicBezier
        //填充颜色
        set1.fillColor = UIColor(red:0.46, green:0.95, blue:0.69, alpha:1.00)
        set1.fillAlpha = 1
        set1.drawCirclesEnabled = true
        set1.lineWidth = 1.8
        set1.circleRadius = 4
        set1.setCircleColor(.white)
        set1.highlightColor = UIColor(red: 244/255, green: 117/255, blue: 117/255, alpha: 1)
        set1.fillAlpha = 1
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
        
        lineChartView.data = data
        set1.drawValuesEnabled = true
        set2.drawValuesEnabled = true
        lineChartView.animate(xAxisDuration: 3, yAxisDuration: 3)
        lineChartView.setNeedsDisplay()
    }
}

let viewController = ChartController()

PlaygroundPage.current.liveView = viewController


