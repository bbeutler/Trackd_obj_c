//
//  APIService.swift
//  Trackd
//
//  Created by Lucky on 2018/11/13.
//  Copyright © 2018 Trident Cloud Limited. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

let kUserLogin = "USER_LOGIN"
let kUserVerifyToken = "USER_VERIFY_TOKEN"
let kUserRegister = "USER_REGISTER"
let kUserChangePassword = "USER_CHANGE_PASSWORD"
let kUserClassification = "USER_CLASSIFICATION"
let kUserSetClassification = "USER_SET_CLASSIFICATION"
let kUserGetClassification = "USER_GET_CLASSIFICATION"
let kUserSetProfile = "USER_SET_PROFILE"
let kUserGetProfile = "USER_GET_PROFILE"
let kUserConfirmEmail = "USER_CONFIRM_EMAIL"

fileprivate var g_sToken = ""
class APIService{
    static func getURLList(onSuccess: @escaping(_ urls: [String: String]) -> Void, onError: @escaping(_ errorMessage: String?) -> Void){
        let url = BASE_URL + "/users/urls/"
        let header = ["Content-Type": "application/json"] as HTTPHeaders
        
        let request = Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: header)
        
        request.validate().responseJSON { response in
            switch response.result{
                case .success:
                    let value = JSON(response.value!).dictionaryObject
                    onSuccess(value as! [String : String])
                    break
                case .failure(let error):
                    onError(error.localizedDescription);
                    break
            }
        }
    }
    
    static func userRegister(email: String, username: String, password: String, onSuccess: @escaping() -> Void, onError: @escaping(_ errorMessage: String?) -> Void){
        
        let header = ["Content-Type": "application/json"] as HTTPHeaders
        let params = ["email": email,
                      "username": username,
                      "password": password] as Parameters
        if let url = g_dicUrl[kUserRegister] {
            let request = Alamofire.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: header)
            
            request.validate().responseJSON { response in
                print(response.debugDescription)
                switch response.result{
                case .success:
                    onSuccess()
                    break
                case .failure(let error):
                    onError(error.localizedDescription);
                    break
                }
            }
        }
    }
    
    static func userLogin(username: String, password: String, onSuccess: @escaping(_ token: [String: String]?) -> Void, onError: @escaping(_ errorMessage: String?) -> Void){
        
        let header = ["Content-Type": "application/json"] as HTTPHeaders
        let params = ["username": username,
                      "password": password] as Parameters
        if let url = g_dicUrl[kUserLogin] {
            let request = Alamofire.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: header)
            
            request.validate().responseJSON { response in
                print(response.debugDescription)
                switch response.result{
                case .success:
                    let value = JSON(response.value!).dictionaryObject
                    onSuccess(value as? [String:String])
                    break
                case .failure(let error):
                    onError(error.localizedDescription);
                    break
                }
            }
        }
    }
    
    
}
