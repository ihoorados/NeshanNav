//
//  SearchViewCollectionViewCell.swift
//  NeshanNav
//
//  Created by Hoorad Ramezani on 7/19/21.
//

import Foundation

class SearchCollectionViewCell: UICollectionViewCell {
    
    private var ContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray6
        return view
    }()
    
    private var titleLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont(name: "IRANYekanMobile", size: 19)!
        label.textColor = .darkText
        label.textAlignment = .right
        return label
    }()
    
    private var addressLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont(name: "IRANYekanMobile", size: 16)!
        label.textAlignment = .right
        label.textColor = .gray
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUIView()
        setupUILayout()
        self.clipsToBounds = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("❌ init(coder:) has not been implemented")
    }
    
    func UpdateViewData(viewData:SearchItem){
        titleLabel.text = viewData.title
        addressLabel.text = viewData.address
    }
    
    private func setupUIView(){
        addSubview(ContainerView)
        ContainerView.addSubview(titleLabel)
        ContainerView.addSubview(addressLabel)
    }
    
    private func setupUILayout(){
        
        ContainerView.anchor(top: topAnchor,
                             left: leftAnchor,
                             bottom: bottomAnchor,
                             right: rightAnchor,
                             paddingTop: 0.0,
                             paddingBottom: 0.0,
                             cornerRadius: 16)
        
        titleLabel.anchor(top: ContainerView.topAnchor,
                          left: ContainerView.leftAnchor,
                          right: ContainerView.rightAnchor)
        
        addressLabel.anchor(top: titleLabel.bottomAnchor,
                          left: ContainerView.leftAnchor,
                          right: ContainerView.rightAnchor)
    }

}
