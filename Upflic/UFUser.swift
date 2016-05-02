//
//  UFUser.swift
//  Upflic
//
//  Created by SICS on 29/04/16.
//  Copyright © 2016 Srishti. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
private var user : UFUser!
class UFUser: NSObject {
    var userId : String!
    var userName: String!
    var userEmail:String!
    
    
    
// MARK:- Singleton 
    
    static let currentUser = UFUser()
    
    private override init() {
        
        
        
    }
    
// MARK:- Method Initialise
    func initWithDetails(dict : [String : String] )
    {
        self.userId = dict["userId"]
        self.userName = dict["userName"]
        self.userEmail = dict["emailId"]
    
    
    }
    
    
//MARK:- Login
    
    //  http://sicsglobal.com/App_projects/app_upflic/json/login.php/login
    func loginWithDetails(parameter:[String:String] ,withCompletion:(success : Bool , result : AnyObject? , error : NSError?)->Void )
    {
    AFNetWorkingServiceManager.sharedManager.parseLinkUsingPostMethod(servicename:"login.php/login", parameter: parameter as NSDictionary) { (success, result, error) -> Void in
        
        if result != nil
        {
            withCompletion(success: true, result: result, error: nil)
            
        }
            
        else
        {
            
            withCompletion(success: false, result: nil, error: error)
        }

        
        }
    }
    
    
//MARK:- SignUp
    
    //   http://sicsglobal.com/App_projects/app_upflic/json/register.php/register
    func signUpWithDetails(parameter:[String:String] ,withCompletion:(success : Bool , result : AnyObject? , error : NSError?)->Void )
    {
        AFNetWorkingServiceManager.sharedManager.parseLinkUsingPostMethod(servicename:"register.php/register", parameter: parameter as NSDictionary) { (success, result, error) -> Void in
            
            
            if result != nil
            {
             

                withCompletion(success: true, result: result, error: nil)
                
            }
                
            else
            {
                
                withCompletion(success: false, result: nil, error: error)
            }

            
        }
        
        
        
    }

    
//   http://sicsglobal.com/App_projects/app_upflic/json/register.php/register
//    username
//    email
//    password
//  http://sicsglobal.com/App_projects/app_upflic/json/login.php/login
//    email
//    password
//
}
