//
//  SignUpVC.swift
//  Trackd
//
//  Created by Lucky on 2018/10/29.
//  Copyright © 2018 Trident Cloud Limited. All rights reserved.
//

import UIKit
import ProgressHUD

class SignUpVC: UIViewController {
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfUsername: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var lblError: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        lblError.text = ""
    }
    
    @IBAction func onBack(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    @IBAction func onCreate(_ sender: Any) {
        if tfEmail.isWhiteEmpty() || tfUsername.isWhiteEmpty() || tfPassword.isWhiteEmpty(){
            lblError.text = "Please fill all input fields."
            return
        }
        
        if !tfEmail.text!.isValidEmail(){
            lblError.text = "Email isn't valid format"
            return
        }
        
        lblError.text = ""
        ProgressHUD.show("", interaction: false)
        APIService.userRegister(email: tfEmail.trimmedText, username: tfUsername.trimmedText, password: tfPassword.text!, onSuccess: {
            ProgressHUD.showSuccess()
            self.performSegue(withIdentifier: "segueThanks", sender: nil)
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
