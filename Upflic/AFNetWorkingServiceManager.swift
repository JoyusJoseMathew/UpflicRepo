//
//  AFNetWorkingServiceManager.swift
//  ClinicalVista
//
//  Created by Srishti on 28/07/15.
//  Copyright (c) 2015 Srishti. All rights reserved.
//

import UIKit
private var serviceManger : AFNetWorkingServiceManager!
class AFNetWorkingServiceManager: NSObject {
    let manager = AFHTTPSessionManager()
//    static var baseUrl : String =
    
    
    //    MARK:- Singleton
    class var sharedManager :AFNetWorkingServiceManager
    {
        
        if serviceManger == nil
        {
            serviceManger = AFNetWorkingServiceManager()
        }
        
        return serviceManger
    }
    
    
    func initWithManager() -> String
    {
        let url : NSURL = NSURL(string: "http://sicsglobal.com/App_projects/app_upflic/json/")!
        let urlString : String = url.absoluteString
        return urlString
    }
    
    
    //MARK:- POST
    func parseLinkUsingPostMethod(servicename servicename:String,parameter:NSDictionary?,completion:(Bool?,AnyObject?,NSError?) -> Void){
        manager.responseSerializer = AFJSONResponseSerializer(readingOptions: NSJSONReadingOptions.AllowFragments)
        
        
        manager.responseSerializer.acceptableContentTypes = NSSet(objects:"application/json", "text/html") as? Set<String>
        let strUrl : String = self.initWithManager()
        manager.POST(strUrl+servicename, parameters: parameter, progress: { (progress) -> Void in
            
            }, success: { (sessionTask, responseObj) -> Void in
                completion(true,responseObj,nil)
            }) { (sessionTask, error) -> Void in
                
                completion(false,nil,error)
        }
    }
    
    
    
}
