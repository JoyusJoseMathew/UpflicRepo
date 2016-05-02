//
//  GenericClass.swift
//  Upflic
//
//  Created by SICS on 30/04/16.
//  Copyright © 2016 Srishti. All rights reserved.
//

import UIKit

class GenericMethod: NSObject {
    
    
    static func callAlertWithTitle(title:String ,message:String?,target : UIViewController )
    {
        
        let alert =   UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Cancel, handler: nil))
        target.presentViewController(alert, animated: true, completion: nil)
        
    }
    
    static func isValidEmail(testStr:String) -> Bool {
        
        let emailRegex: String = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let emailTest: NSPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailTest.evaluateWithObject(testStr)
    }
    

}
