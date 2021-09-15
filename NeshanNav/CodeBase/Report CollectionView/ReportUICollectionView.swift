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
        cell.layer.cornerRadius = 12
        cell.backgroundColor = .clear
        
        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor.yellow.cgColor
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate.select(item: viewModel.items[indexPath.row])
    }
    
}

extension ReportCollectionView : UICollectionViewDelegateFlowLayout {
    
    
    fileprivate func cellViewSize(numberOfItemInARow:Int) -> CGSize {
        
        let width = (Int(self.reportBoxCollectionView.frame.width) - 64) / numberOfItemInARow
        return CGSize(width: width, height: width + 30)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
        return cellViewSize(numberOfItemInARow: 3)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 0 { return CGSize(width: self.view.frame.width, height: 80)}
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader,
                                                                               withReuseIdentifier: "headerView",
                                                                               for: indexPath) as? SectionHeaderCell else {
            return UICollectionReusableView()
        }
        headerView.titleLabel.text = "Send Report"
        headerView.titleLabel.textAlignment = .center
        headerView.titleLabel.textColor = .white
        headerView.titleLabel.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        return headerView
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {

        //Where elements_count is the count of all your items in that
        //Collection view...
        let cellCount = CGFloat(viewModel.items.count)
        if cellCount < 3{

            //Calculate the right amount of padding to center the cells.
            let padding = (cellViewSize(numberOfItemInARow: 3).width / 2) + 16
            return UIEdgeInsets(top: 0, left: padding, bottom: 0, right: padding)
        }
        return UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        //return UIEdgeInsets.zero
    }
}

