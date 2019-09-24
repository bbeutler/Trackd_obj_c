//
//  TrackInfo.swift
//  Trackd
//
//  Created by Lucky on 2018/11/22.
//  Copyright © 2018 Trident Cloud Limited. All rights reserved.
//

import Foundation
import AudioKit

class TrackInfo {
    var nIndex = -1
    var sAudioNames = [String]()
    var state = State.waitForRecord
    var player : AKPlayer?
    var tracked = false
    init(index: Int) {
        nIndex = index
    }
}
