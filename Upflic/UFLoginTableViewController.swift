//
//  UFLoginTableViewController.swift
//  Upflic
//
//  Created by SICS on 29/04/16.
//  Copyright © 2016 Srishti. All rights reserved.
//

import UIKit
import FBSDKLoginKit

class UFLoginTableViewController: UITableViewController {
    
    @IBOutlet var textFieldEmail: UITextField!
    @IBOutlet var textFieldPassword: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK:- Button Actions
    
    
    @IBAction func loginAction(sender: UIButton) {
        
        validateFields()
    }
    
    
    @IBAction func fbLoginAction(sender: UIButton) {
        
        loginWithFacebook()
    }
    
    @IBAction func goToSignUp(sender: UIButton) {
        
        let signUpVc = self.storyboard?.instantiateViewControllerWithIdentifier("UFRegisterTableViewController") as! UFRegisterTableViewController
        self.navigationController?.pushViewControllerWithAnimation(signUpVc)
    }
    
    
    
    // MARK:- TextField Delegate
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    
    // MARK:- Facebook Login
    
    func loginWithFacebook()
    {
        let loginManager = FBSDKLoginManager()
        loginManager.logInWithReadPermissions(["email"], fromViewController: self) { (result, error) -> Void in
            if ((error) != nil) {
                
            } else if (result.isCancelled) {
                
                
            } else {
                
                let request = FBSDKGraphRequest(graphPath: "me", parameters: ["fields":"email,name"], HTTPMethod: "GET")
                request.startWithCompletionHandler({ (connection, result, error : NSError!) -> Void in
                    if(error == nil)
                    {
                        let homeVc = self.storyboard?.instantiateViewControllerWithIdentifier("UFHomeViewController") as! UFHomeViewController
                        let homeNav = UFNavigationViewController()
                        homeNav.viewControllers = [homeVc]
                        UFUser.currentUser.userName = result["name"] as! String
                        (UIApplication.sharedApplication().delegate as! AppDelegate).window?.rootViewController = homeNav
                        print("result \(result)")
                    }
                    else
                    {
                        print("error \(error)")
                    }
                })
            }
        }
    }
    
    // MARK:- Validations
    
    
    func validateFields()
    {
        if (textFieldEmail.text!.characters.count == 0 || textFieldPassword.text!.characters.count == 0)
        {
            GenericMethod.callAlertWithTitle("Please fill all fields!", message: nil, target: self)
        }
        else if !GenericMethod.isValidEmail(textFieldEmail.text!)
        {
            
            GenericMethod.callAlertWithTitle("Invalid email id!", message: "Please enter a valid email id", target: self)
        }
        else
        {
            loginWithEmail(["email":textFieldEmail.text!,"password":textFieldPassword.text!])
        }
        
    }
    
    
    func loginWithEmail(details:[String:String])
    {
        
        KVNProgress.show()
        UFUser.currentUser.loginWithDetails(details) { (success, result, error) -> Void in
            if success
            {
                
                if result!["result"] as! String == "success"
                {
                    KVNProgress.showSuccess()
                    UFUser.currentUser.initWithDetails(result!["details"] as! [String:String])
                    
                    let homeVc = self.storyboard?.instantiateViewControllerWithIdentifier("UFHomeViewController") as! UFHomeViewController
                    let homeNav = UFNavigationViewController()
                    homeNav.viewControllers = [homeVc]
                    (UIApplication.sharedApplication().delegate as! AppDelegate).window?.rootViewController = homeNav
                    
                }
                    
                else
                {
                    KVNProgress.showErrorWithStatus("Invalid email or password !")
                    self.textFieldPassword.text = ""
                    self.textFieldEmail.text = ""
                    
                }
                
            }
            else
            {
                
                KVNProgress.showErrorWithStatus(error?.localizedDescription)
                
            }
        }
    }
    
    
}
