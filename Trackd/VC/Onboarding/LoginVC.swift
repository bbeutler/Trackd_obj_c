//
//  LoginVC.swift
//  Trackd
//
//  Created by Lucky on 2018/10/29.
//  Copyright © 2018 Trident Cloud Limited. All rights reserved.
//

import UIKit
import ProgressHUD
class LoginVC: UIViewController {
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var lblError: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupUI()
    }
    func setupUI(){
        lblError.text = ""
    }
    @IBAction func onBack(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    @IBAction func onLogin(_ sender: Any) {
        if tfEmail.isWhiteEmpty() || tfPassword.isWhiteEmpty(){
            lblError.text = "Please fill all input field"
            return
        }
        
        ProgressHUD.show("", interaction: false)
        APIService.userLogin(username: tfEmail.text!, password: tfPassword.text!, onSuccess: {(token) in
            g_sTokens = token ?? [String:String]()
            self.performSegue(withIdentifier: "segueType", sender: nil)
            ProgressHUD.showSuccess()
        }) { (error) in
            self.lblError.text = error
            ProgressHUD.showError()
        }
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
