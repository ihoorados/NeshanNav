//
//  BillboardRouter.swift
//  NeshanNav
//
//  Created by Hoorad Ramezani on 7/19/21.
//

import Foundation


final class BillboardRouter: BilboardUseCases{
    
    var ExitTapped: (() -> Void)?    
    var CTATapped: (() -> ())?
    
    // MARK: UI Element
    weak var billboardView: UIView?
    weak var view: UIView?
    
    weak var viewModel: MapViewViewModel?
    init(viewModel:MapViewViewModel) {
        self.viewModel = viewModel
    }
    
    func billboardChangetTo(height: CGFloat) {
        guard let view = view else{
            print("🔴 BillboardRouter: view not set.")
            return
        }
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.3, animations:  {
                self.billboardView?.frame.origin.y = view.frame.height - height
            })
        }
    }
    
    deinit {
        print("🗑 BillboardRouter: deinit frome memory.")
    }
    
    
}
