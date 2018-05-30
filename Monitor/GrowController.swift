//
//  GrowController.swift
//  Monitor
//
//  Created by gaof on 2018/5/30.
//  Copyright © 2018年 gaof. All rights reserved.
//

import UIKit
import SwiftyGif
class GrowController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    let gifManager = SwiftyGifManager(memoryLimit:100)
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let gif = UIImage(gifName: "test1")
        imageView.setGifImage(gif, manager: gifManager, loopCount: 3)
        // Use -1 for infinite loop
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        imageView.startAnimatingGif()
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
