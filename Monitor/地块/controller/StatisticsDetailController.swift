//
//  StatisticsDetailController.swift
//  Monitor
//
//  Created by gaof on 2018/5/29.
//  Copyright © 2018年 gaof. All rights reserved.
//

import UIKit
import Reusable
import IBAnimatable

class StatisticsDetailController: UIViewController,StoryboardSceneBased {
    static var sceneStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
    

    @IBOutlet weak var chartContent: AnimatableView!
    @IBAction func backClick(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
