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
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        return label
    }()
    
    var imageView: UIImageView = {
       let imageView = UIImageView()
        imageView.image = UIImage(named: "report_map_camera_speed_view")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configureCell(item: ReportType){
        titleLabel.text = item.text
        titleLabel.adjustsFontSizeToFitWidth = true
        imageView.image = UIImage(named: item.image)
    }
        
    private func setUpView(){
        
        self.addSubview(imageView)
        self.addSubview(titleLabel)

        imageView.heightAnchor.constraint(equalToConstant: self.frame.width - 16).isActive = true
        imageView.anchor(top: self.topAnchor,
                         left: self.leftAnchor,
                         right: self.rightAnchor,
                         paddingTop: 4.0,
                         paddingLeft: 4.0,
                         paddingRight: 4.0)
        

        titleLabel.textAlignment = .center
        titleLabel.textColor = .white
        titleLabel.anchor(top: imageView.bottomAnchor,
                          left: self.leftAnchor,
                          bottom: self.bottomAnchor,
                          right: self.rightAnchor,
                          paddingTop: 4.0,
                          paddingLeft: 4.0,
                          paddingBottom: 4.0,
                          paddingRight: 4.0)

    }


}
