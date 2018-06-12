//
//  MonitoringStationController.swift
//  Monitor
//
//  Created by gaof on 2018/5/28.
//  Copyright © 2018年 gaof. All rights reserved.
//

import UIKit
import Reusable
class MonitoringStationController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "地块"
        self.tableView.backgroundColor = UIColor(named: "color_tableView_bg")
        self.tableView.register(cellType: MonitoringStationCell.self)
        self.tableView.rowHeight = 126
        tableView.separatorStyle = .none
      
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 10
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: MonitoringStationCell.self)
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = MonitoringStationDetailController.instantiate()
        self.navigationController?.pushViewController(detailVC, animated: true)
    }



}
