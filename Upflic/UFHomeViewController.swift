//
//  UFHomeViewController.swift
//  Upflic
//
//  Created by SICS on 30/04/16.
//  Copyright © 2016 Srishti. All rights reserved.
//

import UIKit

class UFHomeViewController: UIViewController {
    
    @IBOutlet var lblUserName: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        lblUserName.text = "Hi \(UFUser.currentUser.userName)"
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func logOutAction(sender: UIButton)
    {
        
        let alert = UIAlertController(title: "Logout?", message: "Are you sure?", preferredStyle: UIAlertControllerStyle.Alert)
        let defaultAction = UIAlertAction(title: "Yes", style: UIAlertActionStyle.Default) { (action) -> Void in
            self.logOut()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil)
        
        alert.addAction(defaultAction)
        alert.addAction(cancelAction)
        
        self.presentViewController(alert, animated: true, completion: nil)
        
        
    }
    
//    MARK:- Logout
    func logOut()
    {
        
        let rootVc = self.storyboard?.instantiateViewControllerWithIdentifier("UFLoginTableViewController") as! UFLoginTableViewController
        (UIApplication.sharedApplication().delegate as! AppDelegate).window?.rootViewController = UFNavigationViewController(rootViewController:rootVc)
        
        
    }
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}
