//
//  SearchRouter.swift
//  NeshanNav
//
//  Created by Hoorad Ramezani on 7/19/21.
//

import Foundation

final class SearchRouter: SearchUseCases{
            
    weak var searchView: UIView?
    weak var view: UIView?
    
    private let viewModel: mapViewModelDelegate
    init(viewModel:mapViewModelDelegate) {
        self.viewModel = viewModel
    }
    
    func userLocation() -> NTLngLat{
        return viewModel.userLocation
    }
    
    func userSelectAddress(location: NTLngLat) {
        viewModel.userSelectLocation(at: location)
        searchViewHeightChangetTo(height: 100)
    }
    
    func cameraMoveToUserLocation() {
        viewModel.cameraMoveToUserLocation()
    }
    
    func searchViewHeightChangetTo(height: CGFloat) {
        guard let view = view else{
            return
        }
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.4, delay: 0.0, options: [.allowUserInteraction,.curveEaseOut]) {
                self.searchView?.frame.origin.y = view.frame.height - height
            }
        }
    }
    
    deinit {
        print("🗑 SearchRouter: deinit frome memory.")
    }
    
    
}
