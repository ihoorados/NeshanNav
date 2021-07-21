//
//  QuickAddressView.swift
//  NeshanNav
//
//  Created by Hoorad Ramezani on 7/22/21.
//

import UIKit

class QuickAddressView: UIView {

    var selection: (() -> Void)?
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    
    lazy var listStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis          = NSLayoutConstraint.Axis.horizontal
        stackView.distribution  = UIStackView.Distribution.fill
        stackView.alignment     = UIStackView.Alignment.leading
        stackView.layoutMargins = UIEdgeInsets(top: 0.0, left: 16.0, bottom: 0.0, right: 16.0)
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.spacing       = 8
        return stackView
    }()
    
    // MARK: Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUIView()
        setupUILayout()
        createQuickAddress()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("❌ init(coder:) has not been implemented")
    }
    
    func setupUIView(){
        addSubview(scrollView)
        scrollView.addSubview(listStackView)
    }
    
    func setupUILayout(){
        
        scrollView.anchor(top: topAnchor,
                          left: leftAnchor,
                          bottom: bottomAnchor,
                          right: rightAnchor,
                          paddingTop: 0.0,
                          paddingLeft: 0.0,
                          paddingBottom: 0.0,
                          paddingRight: 0.0)
        
        listStackView.anchor(top: scrollView.topAnchor,
                             left: scrollView.leftAnchor,
                             bottom: scrollView.bottomAnchor,
                             right: scrollView.rightAnchor,
                             paddingTop: 0.0,
                             paddingLeft: 0.0,
                             paddingBottom: 0.0,
                             paddingRight: 0.0)
    }
    
    
    func createQuickAddress(){
        for _ in 0...6{
            let button = UIButton()
            button.setTitle("Test Case", for: .normal)
            button.backgroundColor = .gray
            button.layer.cornerRadius = 12
            button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
            button.anchor(width: 150, height: 40)
            listStackView.addArrangedSubview(button)
            listStackView.layoutIfNeeded()
        }
    }
    

}
