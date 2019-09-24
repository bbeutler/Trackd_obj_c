//
//  LibraryVC.swift
//  Trackd
//
//  Created by Lucky on 2018/11/2.
//  Copyright © 2018 Trident Cloud Limited. All rights reserved.
//

import UIKit
import AASegmentedControl

class LibraryVC: UIViewController {
    @IBOutlet weak var segType: AASegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setupUI()
    }
    
    func setupUI(){
        segType.segmentTitles = ["My Songs", "Lyrics", "Liked",]
    }
    
    func segmentValueChanged(_ sender: AASegmentedControl) {
        
        // sender.selectedIndex is the selected index
        
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
