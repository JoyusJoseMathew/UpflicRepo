//
//  UFRegisterTableViewController.swift
//  Upflic
//
//  Created by SICS on 29/04/16.
//  Copyright © 2016 Srishti. All rights reserved.
//

import UIKit



class UFRegisterTableViewController: UITableViewController,UITextFieldDelegate {
    
    @IBOutlet var arrayFields: [UITextField]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func registerAction(sender: AnyObject) {
        
        if isValidFields()
        {
        
            signUpWith(["username":arrayFields[0].text!,"email":arrayFields[1].text!,"password":arrayFields[2].text!])
        
        }
    }
   
    @IBAction func backtoLogin(sender: UIButton) {
        
        self.navigationController?.popViewWithAnimation()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK:- TextField Delegate
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
//    MARK:- Validation and Register
    
    func isValidFields()->Bool
    {
        for textfield in arrayFields
        {
            if textfield.text!.containsString(" ")
            {
                GenericMethod.callAlertWithTitle("Invalid \(textfield.placeholder!)", message: "Please enter a valid \(textfield.placeholder!)", target: self)
                return false
            }
            
            if textfield.text?.characters.count == 0
            {
                GenericMethod.callAlertWithTitle("Please fill all fields !", message: "", target: self)
                return false
                
            }
            
            if textfield == arrayFields[1]
            {
                if !GenericMethod.isValidEmail(arrayFields[1].text!)
                {
                    GenericMethod.callAlertWithTitle("Invalid email id!", message: "Please enter a valid email id", target: self)
                    
                    return false
                }
                
            }
            
        }
        
        if arrayFields[2].text !=  arrayFields[3].text
        {
            GenericMethod.callAlertWithTitle("Password doesnt match", message: nil, target: self)
            return false
            
            
        }
        else
        {
            return true
            
        }
        
    }
       
    func signUpWith(details:[String:String])
    {
        KVNProgress.show()
        UFUser.currentUser.signUpWithDetails(details) { (success, result, error) -> Void in
            if success
            {
                if result!["result"] as! String == "success"
                {
                    KVNProgress.showSuccessWithStatus("Success")
                    UFUser.currentUser.initWithDetails(result!["details"] as! [String:String])
                    
                    let homeVc = self.storyboard?.instantiateViewControllerWithIdentifier("UFHomeViewController") as! UFHomeViewController
                    let homeNav = UFNavigationViewController()
                    homeNav.viewControllers = [homeVc]
                    (UIApplication.sharedApplication().delegate as! AppDelegate).window?.rootViewController = homeNav
                    
                }
                else
                {
                 KVNProgress.showErrorWithStatus("Email already exist !")
                }
                
            }
            else
            {
                
                KVNProgress.showErrorWithStatus(error?.description)
                
            }
        }
       
    }

    
}
