//
//  UINavigationController+Animation.swift
//  Upflic
//
//  Created by SICS on 02/05/16.
//  Copyright © 2016 Srishti. All rights reserved.
//

import Foundation
extension UINavigationController
{
    func pushViewControllerWithAnimation(controller:UIViewController)
    {
        UIView.animateWithDuration(0.5) { () -> Void in
            UIView.setAnimationCurve(UIViewAnimationCurve.EaseInOut)
            self.pushViewController(controller, animated: false)
            UIView.setAnimationTransition(UIViewAnimationTransition.CurlUp, forView: self.view, cache: true)
        }
        
        
    }
    
    func popViewWithAnimation()
    {
        UIView.animateWithDuration(0.5) { () -> Void in
            UIView.setAnimationCurve(UIViewAnimationCurve.EaseInOut)
            UIView.setAnimationTransition(UIViewAnimationTransition.CurlDown, forView: self.view, cache: true)
        }
        self.popViewControllerAnimated(false)
        
    }
    
    
}