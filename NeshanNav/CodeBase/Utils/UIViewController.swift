//
//  UIViewController.swift
//  NeshanNav
//
//  Created by Hoorad Ramezani on 7/19/21.
//

import Foundation

extension UIViewController{
    
    /// This function add `vc` to `view`.
    ///
    /// - Parameter vc: The ViewController to add.
    /// - Parameter view: The View to add child VC.
    func addVCToContainer(vc:UIViewController,to view:UIView){
        DispatchQueue.main.async {
            self.addChild(vc)
            vc.view.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
            view.addSubview(vc.view)
            vc.didMove(toParent: self)
        }
    }
    
}
