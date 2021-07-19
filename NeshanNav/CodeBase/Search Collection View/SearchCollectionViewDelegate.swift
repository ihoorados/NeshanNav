//
//  SearchViewCollectionViewDelegate.swift
//  NeshanNav
//
//  Created by Hoorad Ramezani on 7/19/21.
//

import Foundation

class SearchCollectionViewDelegate: NSObject,UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    typealias CellConfigurator = (IndexPath) -> Void
    var delegate: CellConfigurator

    init(delegate:@escaping CellConfigurator) {
        self.delegate = delegate
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // MARK: Search Collection View Selected at Index Path
        delegate(indexPath)
    }
    
    // MARK: Collection View Layout
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 100.0)
    }
    
    deinit {
        print("🗑 SearchViewDelegate: deinit frome memory.")
    }
    
}
