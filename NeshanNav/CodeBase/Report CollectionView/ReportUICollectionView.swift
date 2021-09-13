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

        cell.configureCell(item: viewModel.items[indexPath.row])
        cell.layer.cornerRadius = 20
        cell.backgroundColor = .clear
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
}

extension ReportCollectionView : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let cellSize = (self.reportBoxCollectionView.frame.width - 32) / 3
        return CGSize(width: cellSize, height: cellSize + 40)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 0 { return CGSize(width: self.view.frame.width, height: 80)}
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader,
                                                                               withReuseIdentifier: "headerView",
                                                                               for: indexPath) as? SectionHeaderWithTitleCVCell else {
            return UICollectionReusableView()
        }
        headerView.titleLabel.text = "Send Report"
        headerView.titleLabel.textAlignment = .center
        headerView.titleLabel.textColor = .white
        headerView.titleLabel.font = UIFont.systemFont(ofSize: 21, weight: .semibold)
        return headerView
    }
}

