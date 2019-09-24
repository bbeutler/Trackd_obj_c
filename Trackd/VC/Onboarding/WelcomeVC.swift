//
//  WelcomeVC.swift
//  Trackd
//
//  Created by Lucky on 2018/10/29.
//  Copyright © 2018 Trident Cloud Limited. All rights reserved.
//

import UIKit

class WelcomeVC: UIViewController {
    @IBOutlet weak var btnCreateProfile: UIButton!
    @IBOutlet weak var btnLogin: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupUI()
    }
    
    func setupUI(){
        btnLogin.titleLabel?.textAlignment = NSTextAlignment.center
        btnCreateProfile.setRound(radius: 25)
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
