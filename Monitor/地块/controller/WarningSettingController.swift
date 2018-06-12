//
//  WarningSettingController.swift
//  Monitor
//
//  Created by gaof on 2018/5/30.
//  Copyright © 2018年 gaof. All rights reserved.
//

import UIKit

class WarningSettingController: UITableViewController {

    @IBOutlet weak var switch_auto: UISwitch!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func autoSwitch(_ sender: UISwitch) {
        self.tableView.reloadData()
    }
    

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return self.switch_auto.isOn ? 1 : 5
    }
}
