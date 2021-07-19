//
//  SearchViewCollectionViewDataSource.swift
//  NeshanNav
//
//  Created by Hoorad Ramezani on 7/19/21.
//

import Foundation

class SearchViewCollectionViewDataSource: NSObject,UICollectionViewDataSource{
    
    typealias CellConfigurator = (SearchItem, SearchListCollectionViewCell) -> Void

    var models : [SearchItem]
    private let reuseIdentifier: String
    private let cellConfigurator: CellConfigurator

    init(models: [SearchItem],
         reuseIdentifier: String,
         cellConfigurator: @escaping CellConfigurator) {
        self.models = models
        self.reuseIdentifier = reuseIdentifier
        self.cellConfigurator = cellConfigurator
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return models.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier,
                                                                for: indexPath) as! SearchListCollectionViewCell
        let model = models[indexPath.row]
        cellConfigurator(model, cell)
        return cell
    }
    
    deinit {
        print("🗑 SearchViewDataSource: deinit frome memory.")
    }
}
