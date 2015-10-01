//
//  CLoginCell.swift
//  laPietra
//
//  Created by Adrian Barbos on 8/10/15.
//  Copyright (c) 2015 Adrian Barbos. All rights reserved.
//

import UIKit

class CLoginCell: UITableViewCell {
    
    //---------------------------------------------------//
    //MARK: - FORGOT PASSWORD VARS
    //---------------------------------------------------//
    @IBOutlet weak var forgotPasswordButton: UIButton!
    
    //---------------------------------------------------//
    //MARK: - SIGN UP VARS
    //---------------------------------------------------//
    @IBOutlet weak var signUpButton: UIButton!
    
    //---------------------------------------------------//
    //MARK: - LOGIN VARS
    //---------------------------------------------------//
    @IBOutlet weak var loginView: UIView!
    @IBOutlet weak var loginSeparator: UIView!
    
    //MARK: Email Vars
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var emailStar: UILabel!
    
    //MARK: Password Vars
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var passwordStar: UILabel!
    
    //MARK: Login button Vars
    @IBOutlet weak var loginButton: UIButton!
    
    
    //---------------------------------------------------//
    //MARK: - INIT
    //---------------------------------------------------//
    override func layoutSubviews() {
        self.configureCell()
    }
    
    
    //---------------------------------------------------//
    //MARK: - CONFIGURE CELL
    //---------------------------------------------------//
    
    private func configureCell() {
        self.configureForgotPassword()
        self.configureCreateAccount()
        self.configureLoginView()
    }
    
    //---------------------------------------------------//
    //MARK: - CONFIGURE FORGOT PASSWORD
    //---------------------------------------------------//
    private func configureForgotPassword() {
        let button = self.forgotPasswordButton
        button.setTitle(getString.loginForgotPassword, forState: UIControlState.Normal)
        button.setTitle(getString.loginForgotPassword, forState: UIControlState.Selected)
        button.setTitle(getString.loginForgotPassword, forState: UIControlState.Highlighted)
        button.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        button.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Selected)
        button.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Highlighted)
    }
    
    @IBAction func forgotPassword(sender: UIButton) {
        let story = UIStoryboard(name: "CForgot", bundle: nil)
        let destination = story.instantiateViewControllerWithIdentifier("CForgotVC") as! CForgotVC
        let navigation = Instance.navigationController
        navigation?.pushViewController(destination, animated: true)
    }
    
    //---------------------------------------------------//
    //MARK: - CONFIGURE CREATE ACCOUNT
    //---------------------------------------------------//
    private func configureCreateAccount() {
        let button = self.signUpButton
        button.setTitle(getString.loginSignUp, forState: UIControlState.Normal)
        button.setTitle(getString.loginSignUp, forState: UIControlState.Selected)
        button.setTitle(getString.loginSignUp, forState: UIControlState.Highlighted)
        button.setTitleColor(getColor.secondColor, forState: UIControlState.Normal)
        button.setTitleColor(getColor.secondColor, forState: UIControlState.Selected)
        button.setTitleColor(getColor.secondColor, forState: UIControlState.Highlighted)
    }
    
    @IBAction func createAccount() {
        let story = UIStoryboard(name: "CSignUp", bundle: nil)
        let destination = story.instantiateViewControllerWithIdentifier("CSignUpVC") as! CSignUpVC
        let navigation = Instance.navigationController
        navigation?.pushViewController(destination, animated: true)
    }
    
    //---------------------------------------------------//
    //MARK: - CONFIGURE LOGIN
    //---------------------------------------------------//
    private func configureLoginView() {
        self.configureLoginMainView()
        self.configureLoginViewSeparator()
        self.configureEmailField()
        self.configurePasswordField()
        self.configureLoginButton()
    }
    
    private func configureLoginMainView() {
        let view = self.loginView
        view.backgroundColor = getColor.checkoutFieldBackgroundColor
        view.layer.cornerRadius = 2
        view.layer.borderWidth = 1
        view.layer.borderColor = getColor.checkoutFieldBorderColor.CGColor
    }
    
    private func configureLoginViewSeparator() {
        let separator = self.loginSeparator
        separator.backgroundColor = getColor.checkoutFieldBorderColor
    }
    
    private func configureEmailField() {
        let eField = self.emailField
        eField.textColor = UIColor.whiteColor()
        eField.attributedPlaceholder = NSAttributedString(string:getString.loginEmail,
            attributes:[NSForegroundColorAttributeName: getColor.checkoutFieldPlaceholderColor])
    }
    
    private func configurePasswordField() {
        let passField = self.passwordField
        passField.textColor = UIColor.whiteColor()
        passField.attributedPlaceholder = NSAttributedString(string:getString.loginPassword,
            attributes:[NSForegroundColorAttributeName: getColor.checkoutFieldPlaceholderColor])
    }
    
    private func configureLoginButton() {
        let button = self.loginButton
        button.backgroundColor = getColor.secondColor
        button.layer.cornerRadius = 5
        button.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        button.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Selected)
        button.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Highlighted)
        button.setTitle(getString.loginLogin, forState: UIControlState.Normal)
        button.setTitle(getString.loginLogin, forState: UIControlState.Selected)
        button.setTitle(getString.loginLogin, forState: UIControlState.Highlighted)
    }
    
    
    
    //---------------------------------------------------//
    //MARK: - CONFIGURE LOGIN TAP
    //---------------------------------------------------//
    
    @IBAction func login(sender: UIButton) {
        
        self.validateEmail()
        self.validatePassword()
        
        if self.validateEmail() && self.validatePassword() {
            PKHUD.sharedHUD.contentView = PKHUDProgressView()
            PKHUD.sharedHUD.show()
            self.loginMethod()
        } else {
            let string = getString.loginErrorFields
            PKHUD.sharedHUD.contentView = PKHUDTextViewCustom(text: string, font: UIFont(name: "RobotoSlab-Regular", size: 17)!, textColor: UIColor(rgb: 0x8b8a89), bgColor: UIColor.whiteColor())
            PKHUD.sharedHUD.show()
            PKHUD.sharedHUD.hide(afterDelay: 1.5)
        }
        
    }
    
    
    
    //---------------------------------------------------//
    //MARK: - CONFIGURE LOGIN METHOD
    //---------------------------------------------------//
    
    private func loginMethod() {
        
        let loginAccount = LoginAccount(email: self.emailField.text!, password: self.passwordField.text!)
        loginAccount.loginAccount({
            PKHUD.sharedHUD.hide(animated: true)
            self.accountLoginSuccess()
            }, wrongPassword: {
                
                let string = getString.loginErrorEmailUsed
                PKHUD.sharedHUD.contentView = PKHUDTextViewCustom(text: string, font: UIFont(name: "RobotoSlab-Regular", size: 17)!, textColor: UIColor(rgb: 0x8b8a89), bgColor: UIColor.whiteColor())
                PKHUD.sharedHUD.show()
                PKHUD.sharedHUD.hide(afterDelay: 1.5)
                
            }, failure: {
                
                let string = getString.loginErrorConnection
                PKHUD.sharedHUD.contentView = PKHUDTextViewCustom(text: string, font: UIFont(name: "RobotoSlab-Regular", size: 17)!, textColor: UIColor(rgb: 0x8b8a89), bgColor: UIColor.whiteColor())
                PKHUD.sharedHUD.show()
                PKHUD.sharedHUD.hide(afterDelay: 1.5)
                
        })
        
    }
    
    
    
    //---------------------------------------------------//
    //MARK: - LOGIN SUCCESS -> REGISTER DEVICE FOR APNS
    //---------------------------------------------------//
    
    private func accountLoginSuccess() {
        
        _ = RegisterDevice(success: {
            let story = UIStoryboard(name: "SpashScreen", bundle: nil)
            let destination = story.instantiateViewControllerWithIdentifier("SpashScreenVC") as! SpashScreenVC
            let navigation = Instance.navigationController
            navigation!.pushViewController(destination, animated: false)
            }, failure: {
                let string = getString.loginErrorConnection
                PKHUD.sharedHUD.contentView = PKHUDTextViewCustom(text: string, font: UIFont(name: "RobotoSlab-Regular", size: 17)!, textColor: UIColor(rgb: 0x8b8a89), bgColor: UIColor.whiteColor())
                PKHUD.sharedHUD.show()
                PKHUD.sharedHUD.hide(afterDelay: 1.5)
        })
        
    }
    
    //---------------------------------------------------//
    //MARK: - VALIDATIONS
    //---------------------------------------------------//
    private func validateEmail() -> Bool {
        if self.emailField.text!.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet()).characters.count > 0 {
            self.emailStar.hidden = true
            return true
        }
        self.emailStar.hidden = false
        return false
    }
    
    private func validatePassword() -> Bool {
        if self.passwordField.text!.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet()).characters.count > 0 {
            self.passwordStar.hidden = true
            return true
        }
        self.passwordStar.hidden = false
        return false
    }
    
}
