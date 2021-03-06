//
//  SearchViewDelegate.swift
//  NeshanNav
//
//  Created by Hoorad Ramezani on 7/19/21.
//

import Foundation

protocol SearchViewDelegate: AnyObject {
    func openSearchView()
    func closeSearchView()
    func isLoading(_ status: Bool)
    func loadSearchList(items: [SearchItem])
}

extension SearchView: SearchViewDelegate{
    
    func isLoading(_ status:Bool) {
        DispatchQueue.main.async {
            if status {
                self.activityIndactor.startAnimating()
            }else{
                self.activityIndactor.stopAnimating()
            }
        }
    }
    
    func openSearchView(){
        
        viewModel.delegate?.searchViewHeightChangetTo(height: view.frame.height - 50.0)
        
        let image = UIImage(systemName: "x.square.fill")?.withRenderingMode(.alwaysTemplate)
        liveUserLocationButton.setBackgroundImage(image, for: .normal)
        liveUserLocationButton.tintColor = UIColor.systemRed
        liveUserLocationButton.tag = 1

    }
    
    func closeSearchView(){
        searchTextFeild.resignFirstResponder()
        searchTextFeild.text = ""
        loadSearchList(items: [])

        viewModel.delegate?.searchViewHeightChangetTo(height: 100.0)
        
        let image = UIImage(named: "LiveLocationIcon")
        liveUserLocationButton.setBackgroundImage(image, for: .normal)
        liveUserLocationButton.tag = 0
    }
    

    func loadSearchList(items:[SearchItem]){
        isLoading(false)
        let dataSource = SearchCollectionViewDataSource(models: items,
                                              reuseIdentifier: ListCellIdentifire,
                                              cellConfigurator: { viewModel, cell in
            cell.UpdateViewData(viewData: viewModel)
        })
        
        let delegate = SearchCollectionViewDelegate { [weak self] indexPath in
            self?.searchTextFeild.resignFirstResponder()
            self?.viewModel.selectAddress(at: indexPath)
        }
        DispatchQueue.main.async {
            self.searchListCollectionView.dataSource = dataSource
            self.searchListCollectionView.delegate = delegate
            self.ListDataSource = dataSource
            self.ListDelegate = delegate
        }
    }
    
}
