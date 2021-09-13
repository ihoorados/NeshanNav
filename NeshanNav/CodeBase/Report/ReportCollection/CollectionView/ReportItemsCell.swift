//
//  ReportItemsCell.swift
//  NeshanNav
//
//  Created by Hoorad Ramezani on 13/9/21.
//

import Foundation
import UIKit

class ReportItemsCell: UICollectionViewCell {
    
    var titleLabel : UILabel = {
        let label = UILabel()
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configureCell(text: String){
        titleLabel.text = text
    }
    
    private func setUpView(){
        addTitle()
    }
        
    private func addTitle(){
        self.addSubview(titleLabel)
        titleLabel.anchor(top: self.topAnchor,left: self.leftAnchor,bottom: self.bottomAnchor, right: self.rightAnchor,paddingTop: 0.0,paddingBottom: 0.0)
        titleLabel.textAlignment = .center
        titleLabel.textColor = .white
    }


}
