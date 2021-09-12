//
//  SearchViewModel.swift
//  NeshanNav
//
//  Created by Hoorad Ramezani on 7/19/21.
//

import Foundation


class SearchViewModelImpl : SearchViewModel{
    
    var listItem : [SearchItem] = []
    var retryRequest: (() -> ())?
    
    weak var delegate: SearchUseCases?
    weak var searchViewDelegate: SearchViewDelegate?

    let searchRepo:SearchLocationRepository
    
    init(searchRepo:SearchLocationRepository = SearchLocationRepositoryImpl()) {
        self.searchRepo = searchRepo
    }
    
    
    func selectAddress(at indexPath:IndexPath){
        guard let location = NTLngLat(x: listItem[indexPath.row].location.x,
                                      y: listItem[indexPath.row].location.y) else {
            return
        }
        delegate?.userSelectAddress(location: location)
    }
    
    func requestForSearchingLocation(term:String){
        
        guard let userLocation = delegate?.userLocation() else {
            return
        }
        let latitude = userLocation.getY()
        let longitude = userLocation.getX()
        let location = Location(latitude: latitude, longitude: longitude)
        
        searchRepo.getLocationsOverNetwork(at: location, term: term) { [weak self] result in
            switch result {
                case .success(let searchResult):
                    self?.listItem = searchResult.items
                    self?.searchViewDelegate?.loadSearchList(items: searchResult.items)
                case .failure(_):
                    self?.retryRequest = {
                        self?.requestForSearchingLocation(term: term)
                    }
            }
        }
    }
    
}
