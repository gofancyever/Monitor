//
//  MonitoringStationController.swift
//  Monitor
//
//  Created by gaof on 2018/5/28.
//  Copyright © 2018年 gaof. All rights reserved.
//

import UIKit
import Reusable
import CollectionKit
class MonitoringStationController: CollectionViewController {

    var dataSource = ["1","2","3"]
    let presenter = WobblePresenter()
    let dataProvider = ArrayDataProvider<Int>(data: Array(0..<15)) { (_, data) in
        return "\(data)"
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "地块"
        collectionView.backgroundColor = UIColor(named: "color_tableView_bg")
//        collectionView.contentInset = UIEdgeInsetsMake(30, 10, 54, 10)
        
        let provider = CollectionProvider(
                dataProvider: dataProvider,
                viewGenerator: { (data, index) -> MonitoringStationCell in
                    let cell = MonitoringStationCell.loadFromNib()
                    cell.frame.size = CGSize(width: self.collectionView.frame.width, height: 126)
                    return MonitoringStationCell.loadFromNib()
            },
                viewUpdater: { (view: MonitoringStationCell, data: Int, at: Int) in
//                    view.configure(with: data)
            }
        )

        provider.layout = FlowLayout(lineSpacing: 0)
        print(self.view.frame.width)
        provider.sizeProvider = { (_, view, size) -> CGSize in
            return CGSize(width: size.width, height: 126)
        }
        provider.presenter = presenter
        provider.tapHandler = { cell,idx,data in
            let detailVC = MonitoringStationDetailController.instantiate()
            self.navigationController?.pushViewController(detailVC, animated: true)
        }
        self.provider = provider

      
    }






}
