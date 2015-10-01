//
//  LoginAccount.swift
//  laPietra
//
//  Created by Adrian Barbos on 8/12/15.
//  Copyright (c) 2015 Adrian Barbos. All rights reserved.
//

import UIKit

class LoginAccount: NSObject {

    let method = "userLogin"
    let status = "status"
    
    let emailKey = "email"
    let passwordKey = "password"
    
    var emailValue: String!
    var passwordValue: String!
    
    required init(email: String, password: String) {
        super.init()
        self.emailValue = email
        self.passwordValue = password
    }
    
    func loginAccount(success: () -> (), wrongPassword: () -> (), failure: () -> () ) {
    
        let parameters = [
            GlobalConstant.METHOD : self.method,
            GlobalConstant.PROJECT_ID_KEY : GlobalConstant.PROJECT_ID_VALUE,
            self.emailKey : self.emailValue,
            self.passwordKey : self.passwordValue
        ]
        
        let login = AFHTTPRequestOperationManager()
        login.responseSerializer.acceptableContentTypes = NSSet(object: "text/html") as Set<NSObject>
        login.POST(
            GlobalConstant.URL,
            parameters: parameters,
            success: { (operation, responseObject) -> Void in
                if let response = responseObject as? NSDictionary {
                    if let status = response[self.status] as? Int {
                        if status == 1 {
                            
                            let userData = UserData()
                            let userID = response["id_user"] as! String
                            userData.userId = "\(userID)"
                            userData.name = response["name"] as! String
                            userData.surname = response["surname"] as! String
                            userData.email = self.emailValue
                            userData.id = nil
                            userData.phone = nil
                            
                            success()
                            
                        } else {
                            wrongPassword()
                        }
                    } else{
                        failure()
                    }
                } else {
                    failure()
                }
            },
            failure: { (operation, error) -> Void in
                failure()
            }
        )
    }
    
}
