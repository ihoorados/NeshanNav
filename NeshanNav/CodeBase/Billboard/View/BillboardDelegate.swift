//
//  BillboardDelegate.swift
//  NeshanNav
//
//  Created by Hoorad Ramezani on 7/19/21.
//

import Foundation

protocol BillboardDelegate: AnyObject {
    func updateViewDataModel(with route: RouteModel)
    func updateViewDataModel(with distance: Element)
    func updateViewToNavigateState()
    func isLoading(loading:Bool)
    func updateViewDataWithError()
}

extension BillboardView: BillboardDelegate{
    
    func isLoading(loading: Bool) {
        DispatchQueue.main.async {
            if loading{
                self.spinner.startAnimating()
                self.delegate?.billboardChangetTo(height: 90.0)
                self.titleLabel.text = "در حال بررسی ..."
                self.routeNameStackView.alpha = 0
                self.routeAddressStackView.alpha = 0
            }else{
                self.spinner.stopAnimating()
            }
        }
    }
    
    func updateViewDataModel(with route: RouteModel) {
        // Update Route Info Here
        // UI Element should update in main thread
        DispatchQueue.main.async {
            self.titleLabel.text = "نقطه انتخاب شده"
            
            self.routeAddressStackView.alpha = 1
            self.routeaddressLabel.text = route.formatted_address
            self.routeAddressIcon.image = UIImage(named: "LocationIC")
            
            self.routeNameStackView.alpha = 1
            self.routeNameLabel.text = route.route_name
            self.routeNameIcon.image = UIImage(named: "streetIcon")
            self.routeNameIcon.tintColor = .white
            
            self.ConfigButtonToRoute()
            self.delegate?.billboardChangetTo(height: 250)
        }
    }
    
    func updateViewDataModel(with distance: Element) {
        // Update Route Info Here
        DispatchQueue.main.async {
            self.titleLabel.text = "فاصله تا مقصد"
            self.routeaddressLabel.text = "\(distance.distance.text) , \(distance.duration.text)"
            self.routeNameStackView.alpha = 1
            self.routeAddressStackView.alpha = 1
            self.ConfigButtonToNavigate()
            self.delegate?.billboardChangetTo(height: 250)
        }
    }
    
    func updateViewToNavigateState() {
        // Update Route Info Here
        DispatchQueue.main.async {
            self.HiddenCTAButton()
            self.delegate?.billboardChangetTo(height: 190)
        }
    }
    
    func updateViewDataWithError() {
        // Update Route Info Here
        // UI Element should update in main thread
        DispatchQueue.main.async {
            self.titleLabel.text = "مجددا تلاش کنید"
            self.spinner.stopAnimating()
            self.routeNameStackView.alpha = 0
            self.routeAddressStackView.alpha = 0
            self.ConfigButtonToFaild()
            self.delegate?.billboardChangetTo(height: 250)
        }
    }
}
