//
//  SendReportVC.swift
//  NeshanNav
//
//  Created by Hoorad Ramezani on 12/9/21.
//

import UIKit

class SendReportViewController: UIViewController {
    
    /* ////////////////////////////////////////////////////////////////////// */
    // MARK: Dependency Injection
    /* ////////////////////////////////////////////////////////////////////// */
    
    //weak var viewModel: SendReportViewModel?
    init(viewModel: SendReportViewModel) {
        
        //self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /* ////////////////////////////////////////////////////////////////////// */
    // MARK: Lifecycle
    /* ////////////////////////////////////////////////////////////////////// */

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = #colorLiteral(red: 0.1647058824, green: 0.1725490196, blue: 0.2, alpha: 1)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        setupUIView()
        setupUILayout()
        setupUIEvent()
        BoardRouteToMainList()
    }
    

    /* ////////////////////////////////////////////////////////////////////// */
    // MARK: UI Properties
    /* ////////////////////////////////////////////////////////////////////// */
    
    // MARK: UI Views Properties
    lazy var BoardContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.1647058824, green: 0.1725490196, blue: 0.2, alpha: 1)
        view.alpha = 1
        return view
    }()
    
    lazy var backButton: UIButton = {
        let button = UIButton()
        let image = UIImage.init(systemName: "arrow.backward")?.withTintColor(.white)
        button.setImage(image, for: .normal)
        button.imageView?.tintColor = .white
        return button
    }()
    
    /* ////////////////////////////////////////////////////////////////////// */
    // MARK: UI View
    /* ////////////////////////////////////////////////////////////////////// */
    
    func setupUIView(){
        
        self.view.addSubview(BoardContainerView)
        self.view.addSubview(backButton)
    }
    
    func setupUILayout(){
        
        backButton.anchor(top: self.view.topAnchor,
                          left: self.view.leftAnchor, width: 30, height: 30)
        
        BoardContainerView.anchor(top: backButton.bottomAnchor,
                                  left: self.view.leftAnchor,
                                  bottom: self.view.bottomAnchor,
                                  right: self.view.rightAnchor,
                                  cornerRadius: 16.0)
    }
    
    fileprivate func setupUIEvent(){
        
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
    }
    
    @objc fileprivate func backButtonTapped(){
        BoardBack()
    }

}
