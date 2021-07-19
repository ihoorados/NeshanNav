//
//  LocationInfo.swift
//  NeshanNav
//
//  Created by Hoorad Ramezani on 7/19/21.
//

import UIKit

class LocationInfo: UIView {
    
    var routeNameIcon:UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "streetIcon")
        imageView.tintColor = .label
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    var routeNameLabel: UILabel = {
       let label = UILabel()
        label.textAlignment = .right
        label.font = UIFont(name: "IRANYekanMobile", size: 23)!
        return label
    }()
    
    var routeNameStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis          = NSLayoutConstraint.Axis.horizontal
        stackView.distribution  = UIStackView.Distribution.fill
        stackView.alignment     = UIStackView.Alignment.center
        stackView.spacing       = 12
        return stackView
    }()
    
    var routeAddressIcon:UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "LocationIC")
        return imageView
    }()
    
    var routeaddressLabel: UILabel = {
       let label = UILabel()
        label.textAlignment = .right
        label.numberOfLines = 1
        label.font = UIFont(name: "IRANYekanMobile", size: 17)!
        return label
    }()

    var routeAddressStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis          = NSLayoutConstraint.Axis.horizontal
        stackView.distribution  = UIStackView.Distribution.fill
        stackView.alignment     = UIStackView.Alignment.center
        stackView.spacing       = 12
        return stackView
    }()
    
    // MARK: Setup UI View
    //       Add UI element to view
    private func setupUIView(){

        addSubview(routeNameStackView)
        addSubview(routeAddressStackView)
        
        routeNameStackView.addArrangedSubview(routeNameLabel)
        routeNameStackView.addArrangedSubview(routeNameIcon)
        
        routeAddressStackView.addArrangedSubview(routeaddressLabel)
        routeAddressStackView.addArrangedSubview(routeAddressIcon)
        
        print("✅ BillboardView : setup UIViews Completed.")
    }
    
    // MARK: Setup UI Layout
    //       Configure UI Layout Element
    private func setupUILayout(){
                        
        routeNameIcon.anchor(width: 25, height: 25)
        routeAddressIcon.anchor(width: 20, height: 20)

        routeNameStackView.anchor(top: bottomAnchor,
                                  left: leftAnchor,
                                  right: rightAnchor,
                                  paddingTop: 8.0,
                                  height: 50, cornerRadius: 0)
        routeAddressStackView.anchor(top: routeNameStackView.bottomAnchor,
                                     left: leftAnchor,
                                     right: rightAnchor,
                                     paddingTop: 4.0,
                                     height: 40, cornerRadius: 0)
        print("✅ BillboardView : setup UILayouts completed.")
    }
    
    
    


}
