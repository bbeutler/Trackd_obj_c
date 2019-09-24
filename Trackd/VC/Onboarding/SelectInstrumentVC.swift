//
//  SelectInstrumentVC.swift
//  Trackd
//
//  Created by Lucky on 2018/10/29.
//  Copyright © 2018 Trident Cloud Limited. All rights reserved.
//

import UIKit

class SelectInstrumentVC: UIViewController {
    @IBOutlet weak var btnDone: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupUI()
    }
    
    func setupUI(){
        btnDone.setRound(radius: 25)
    }
    
    @IBAction func onBack(_ sender: Any) {
        navigationController?.popViewController(animated: true)
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
