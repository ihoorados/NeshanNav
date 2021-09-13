//
//  ReportUICollectionView.swift
//  NeshanNav
//
//  Created by Hoorad Ramezani on 13/9/21.
//

import Foundation

import Foundation
import UIKit

extension ReportCollectionView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return viewModel.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = reportBoxCollectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifire, for: indexPath) as! ReportItemsCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
}

extension ReportCollectionView : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: self.reportBoxCollectionView.frame.width - 32, height: 48)
    }
}

