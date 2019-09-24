//
//  Extensions.swift
//  Trackd
//
//  Created by Lucky on 2018/10/29.
//  Copyright © 2018 Trident Cloud Limited. All rights reserved.
//

import Foundation
import UIKit

extension Double {
    var clean: String {
        return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(format: "%.1f", self)
    }
}

extension String{
    func isValidEmail()->Bool{
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailTest.evaluate(with:self)
    }
    
    func isWhiteEmpty()->Bool{
        return (self.trimmingCharacters(in: .whitespacesAndNewlines).count == 0)
    }
}
extension UIView{
    func setRound(radius: CGFloat){
        layer.cornerRadius = radius
        clipsToBounds = true
    }
}

extension UITextField{
    func setPadding(fLeft: CGFloat, fRight: CGFloat){
        leftView = UIView(frame: CGRect(x: 0, y: 0, width: fLeft, height: 0))
        leftViewMode = .always
        
        rightView = UIView(frame: CGRect(x: 0, y: 0, width: fRight, height: 0))
        rightViewMode = .always
    }
    
    func isWhiteEmpty()->Bool{
        return self.text!.isWhiteEmpty()
    }
    
    var trimmedText : String{
        return self.text!.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}

extension UITableView{
    func getIndexPathOf(subview: UIView) ->IndexPath{
        var view = subview
        while !(view is UITableViewCell) {
            view = view.superview!
        }
        return indexPath(for: view as! UITableViewCell)!
    }
}

extension UICollectionView{
    func getIndexPathOf(subview: UIView) ->IndexPath{
        var view = subview
        while !(view is UICollectionViewCell) {
            view = view.superview!
        }
        return indexPath(for: view as! UICollectionViewCell)!
    }
}

extension UIViewController{
    func showOkAlert(title: String, msg: String){
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
