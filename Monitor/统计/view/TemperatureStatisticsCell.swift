//
//  TemperatureStatisticsCell.swift
//  Monitor
//
//  Created by gaof on 2018/6/7.
//  Copyright © 2018年 gaof. All rights reserved.
//

import UIKit
import Charts
class TemperatureStatisticsCell: UICollectionViewCell {

    @IBOutlet weak var lab_title: UILabel!
    @IBOutlet var chartView: LineChartView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

}
