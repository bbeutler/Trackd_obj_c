//
//  Global.swift
//  Trackd
//
//  Created by Lucky on 2018/8/8.
//  Copyright © 2018 Lucky. All rights reserved.
//

import Foundation
import UIKit

let BASE_URL = "http://core.trackd-api.appspot.com"
var g_dicUrl = [String: String]()
var g_sTokens = [String: String]()
let g_sizeScreen = UIScreen.main.bounds
let g_bTypeCreate = true

enum State {
    case waitForRecord
    case readyToRecord
    case recording
    case readyToPlay
}

func getDateFromString(dateString: String) -> Date{
    let dateFormatter = ISO8601DateFormatter()
    let date = dateFormatter.date(from:dateString)!
    
    let calendar = Calendar.current
    let components = calendar.dateComponents([.year, .month, .day, .hour], from: date)
    let finalDate = calendar.date(from:components)
    
    return finalDate!
}

func getDocumentsDirectory() -> URL {
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    return paths[0]
}
