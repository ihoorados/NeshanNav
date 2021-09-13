//
//  SectionHeader.swift
//  NeshanNav
//
//  Created by Hoorad Ramezani on 13/9/21.
//

import Foundation
import UIKit

class SectionHeaderCell: UICollectionReusableView {
    
    lazy var titleLabel:UILabel = {
       let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 23, weight: .bold)
        label.numberOfLines = 2
        return label
    }()
    
    lazy var iconImageView:UIImageView = {
       let imgView = UIImageView()
        imgView.image = UIImage(named: "BoardLogo")
        imgView.contentMode = .scaleAspectFit
        return imgView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUIView()
        setupUIlayout()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setupUIView() {
        self.addSubview(titleLabel)
    }
    
    func setupUIlayout() {
        titleLabel.anchor(top: self.topAnchor,
                         left: self.leftAnchor,
                         bottom: self.bottomAnchor,
                         right: self.rightAnchor,
                         paddingTop: 0.0,paddingLeft: 0.0,paddingBottom: 0.0,paddingRight: 0.0)
    }
    
    func setupHeaderWithLogo(){
        self.addSubview(iconImageView)
        iconImageView.anchor(top: self.topAnchor, bottom: self.bottomAnchor, right: self.rightAnchor,paddingRight: 0.0, width: 100)
        titleLabel.anchor(top: self.topAnchor,
                         left: self.leftAnchor,
                         bottom: self.bottomAnchor,
                         right: iconImageView.leftAnchor,
                         paddingTop: 0.0,paddingLeft: 0.0,paddingBottom: 0.0,paddingRight: 0.0)
    }
    
}


