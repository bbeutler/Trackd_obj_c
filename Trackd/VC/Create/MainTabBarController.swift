//
//  MainTabBarController.swift
//  Trackd
//
//  Created by Lucky on 2018/11/20.
//  Copyright © 2018 Trident Cloud Limited. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {
    static var shared : MainTabBarController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        MainTabBarController.shared = self
        self.selectedIndex = 2
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
