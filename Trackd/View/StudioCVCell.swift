//
//  StudioCVCell.swift
//  Trackd
//
//  Created by Lucky on 2018/11/18.
//  Copyright © 2018 Trident Cloud Limited. All rights reserved.
//

import UIKit

class StudioCVCell: UICollectionViewCell {
    @IBOutlet weak var imgRecord: UILabel!
    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var btnClose: UIButton!
    @IBOutlet weak var viewBack: UIView!
    
    var state = State.waitForRecord
    var index = -1
    
    let colors = [#colorLiteral(red: 0.9321538806, green: 0.518150866, blue: 0.4742839336, alpha: 1), #colorLiteral(red: 0.6, green: 0.6274509804, blue: 0.7529411765, alpha: 1), #colorLiteral(red: 0.963609755, green: 0.7558342218, blue: 0.5163155794, alpha: 1), #colorLiteral(red: 0, green: 0.739561379, blue: 0.8903083205, alpha: 1)]
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    
    func setupUI(){
        if index < 0{
            return
        }
        
        btnClose.isHidden = true
        imgRecord.setRound(radius: 10)
        switch state {
            case .waitForRecord:
                imgRecord.isHidden = true
                viewBack.backgroundColor = UIColor(white: CGFloat(1.0 - ((255.0-215.0)/255.0) * Double(index)/4.0), alpha: 1)
                lblStatus.text = "Track\(index+1)"
                break;
            case .readyToRecord:
                viewBack.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                imgRecord.backgroundColor = #colorLiteral(red: 0.9058823529, green: 0.431372549, blue: 0.4, alpha: 1)
                imgRecord.isHidden = false
                lblStatus.text = "Record"
                break;
            case .recording:
                viewBack.backgroundColor = #colorLiteral(red: 0.9058823529, green: 0.431372549, blue: 0.4, alpha: 1)
                imgRecord.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                imgRecord.isHidden = false
                lblStatus.text = "Record"
                break;
            case .readyToPlay:
                viewBack.backgroundColor = colors[index]
                btnClose.isHidden = false
                imgRecord.isHidden = true
                lblStatus.text = "Track\(index+1)"
                break;
        }
    }
}
