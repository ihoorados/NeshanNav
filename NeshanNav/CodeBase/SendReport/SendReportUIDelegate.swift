//
//  SendReportUIDelegate.swift
//  NeshanNav
//
//  Created by Hoorad Ramezani on 13/9/21.
//
import Foundation
import UIKit

protocol BoardUIDelegate: AnyObject{
    
    func BoardRouteTo(item: ReportType)
}

extension SendReportViewController : BoardUIDelegate{
    
    func BoardRouteTo(item: ReportType){
        removeChildVCs()
        // Add New Card
        let vc = SendReportViewController()
        vc.view.tag = 22
        addVCToContainer(vc: vc, to: BoardContainerView, navigationTo: .left)
    }
    
}


enum Navigation {
    case right
    case left
    case fade
    case top
}

extension UIViewController{
    
    func addVCToContainer(vc:UIViewController,to view:UIView,navigationTo:Navigation){

        DispatchQueue.main.async {
            self.addChild(vc)
            vc.view.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
            switch navigationTo{
            case .right:
                vc.view.center.x -= self.view.frame.width
            case .left:
                vc.view.center.x += self.view.frame.width
            case .fade:
                print("fade is Only for removing")
            case .top:
                vc.view.center.y += self.view.frame.height
            }
            view.addSubview(vc.view)
            vc.didMove(toParent: self)
            UIView.animate(withDuration: 0.9, delay: 0.2,
                           usingSpringWithDamping: 0.6,
                           initialSpringVelocity: 0.8,
                           options: [.allowUserInteraction,.allowAnimatedContent,.curveEaseOut]) {
                switch navigationTo{
                case .right:
                    vc.view.center.x += self.view.frame.width
                case .left:
                    vc.view.center.x -= self.view.frame.width
                case .top:
                    vc.view.center.y -= self.view.frame.height
                case .fade:
                    print("fade is Only for removing")
                }
            } completion: { _ in
                //view.layoutIfNeeded()
            }
        }
    }
    
    func removeChild(navigationTo:Navigation){
        guard let PracticeBoardChild: UIViewController = getPracticeBoardVC() else {
            return
        }
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.3, delay: 0.3, options: [.allowUserInteraction,.allowAnimatedContent]) {
                switch navigationTo {
                case .right:
                    PracticeBoardChild.view.center.x += self.view.frame.width
                case .left:
                    PracticeBoardChild.view.center.x -= self.view.frame.width
                case .fade:
                    PracticeBoardChild.view.transform = CGAffineTransform(scaleX: 0.03, y: 0.03)
                    PracticeBoardChild.view.center.x -= self.view.frame.width
                case .top:
                    print("Navigation To Top Not set yet")
                }
            } completion: { (true) in
                 PracticeBoardChild.willMove(toParent: nil)
                 PracticeBoardChild.view.removeFromSuperview()
                 PracticeBoardChild.removeFromParent()
            }
        }
    }
    
    
    func removeChildVCs(){
        guard let PracticeBoardChild: UIViewController = getPracticeBoardVC() else {
            return
        }
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.3, delay: 0.0, options: [.allowUserInteraction,.allowAnimatedContent]) {
                PracticeBoardChild.view.center.x -= self.view.frame.width
            } completion: { (true) in
                PracticeBoardChild.willMove(toParent: nil)
                PracticeBoardChild.view.removeFromSuperview()
                PracticeBoardChild.removeFromParent()
            }
        }
    }

    fileprivate func getPracticeBoardVC() -> UIViewController?{
        for child in self.children{
            if child.view.tag == 22 {
                return child
            }
        }
        return nil
    }
    
    
}
