//
//  SearchView.swift
//  NeshanNav
//
//  Created by Hoorad Ramezani on 7/19/21.
//

import Foundation
import UIKit

class SearchView: UIViewController {

    // MARK: - Dependency Injection
    /*
             - Protocol SearchUseCases
     */
    //var viewModel : BillboardViewModelDelegate
    
    var ListDataSource: SearchCollectionViewDataSource?
    var ListDelegate: SearchCollectionViewDelegate?

    var viewModel: SearchViewModel = SearchViewModelImp()
    init(delegate: SearchUseCases) {
        super.init(nibName: nil, bundle: nil)
        viewModel.searchViewDelegate = self
        viewModel.delegate = delegate
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: app life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        print("📲 SearchView view did load")
        initUISetup()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("📱 SearchView view did appear")
        closeSearchView()
    }
    
    lazy var ContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()

    let ListCellIdentifire = "ListCellIdentifire"
    // MARK: Lazy word Collection View object
    lazy var searchListCollectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 8.0, left: 0.0, bottom: 8.0, right: 0.0)
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 8.0
        layout.minimumInteritemSpacing = 8.0
        let CollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        CollectionView.translatesAutoresizingMaskIntoConstraints = false
        CollectionView.showsVerticalScrollIndicator = false
        CollectionView.showsHorizontalScrollIndicator = false
        CollectionView.backgroundColor = .white
        return CollectionView
    }()
    
    lazy var searchTextFeild: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .systemBackground
        textField.clearButtonMode = .always
        textField.placeholder = "کجا میخوای بری؟"
        textField.layer.masksToBounds = true
        textField.clipsToBounds = true
        textField.textAlignment = .right
        textField.font = UIFont(name: "IRANYekanMobile", size: 21)!
        var image = UIImage(systemName: "magnifyingglass")!
        textField.withImage(direction: .Left, image: image, colorSeparator: .systemGray , colorBorder: .clear)
        textField.semanticContentAttribute = .forceRightToLeft

        //Basic texfield Setup
        textField.borderStyle = .none

        //To apply corner radius
        textField.layer.cornerRadius = textField.frame.size.height / 2

        //To apply border
        textField.layer.borderWidth = 0.0
        textField.layer.borderColor = UIColor.gray.cgColor

        //To apply Shadow
        textField.layer.shadowOpacity = 1.0
        textField.layer.shadowRadius = 2.5
        textField.layer.shadowOffset = CGSize.init(width: 0, height: 3) // Use any CGSize
        textField.layer.shadowColor = UIColor.darkText.cgColor

        return textField
    }()
    
    var liveUserLocationButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        let image = UIImage(named: "LiveLocationIcon")
        button.setBackgroundImage(image, for: .normal)
        button.tintColor = UIColor.systemRed
        button.clipsToBounds = true
        return button
    }()
    
    lazy var activityIndactor:UIActivityIndicatorView = {
        let ai = UIActivityIndicatorView(style: .large)
        ai.color = .darkText
        ai.hidesWhenStopped = true
        return ai
    }()
    
    var quickAddressStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis          = NSLayoutConstraint.Axis.horizontal
        stackView.distribution  = UIStackView.Distribution.fill
        stackView.alignment     = UIStackView.Alignment.center
        stackView.spacing       = 12
        return stackView
    }()
    
    // MARK: - initials Setup For Practice VC
    func initUISetup(){
        setupUIView()
        setupUILayout()
        setupUIEvent()
        setupCollectionView()
    }
    
    // MARK: Setup UIView
    private func setupUIView(){
            
        // Mark: - Add Container View
        view.addSubview(searchTextFeild)
        view.addSubview(liveUserLocationButton)

        view.addSubview(ContainerView)
        ContainerView.addSubview(searchListCollectionView)
        ContainerView.addSubview(quickAddressStackView)
        view.addSubview(activityIndactor)

        print("✅ SearchView : setup UIView Completed.")
    }
    
    // MARK: Setup UILayout
    private func setupUILayout(){
        
        liveUserLocationButton.anchor(top: self.view.topAnchor,
                                     left: self.view.leftAnchor,
                                     paddingTop: 24.0,
                                     width: 44, height: 44)
        
        searchTextFeild.anchor(left: liveUserLocationButton.rightAnchor,
                               right: self.view.safeAreaLayoutGuide.rightAnchor,
                               height: 48, cornerRadius: 25)
        searchTextFeild.centerY(inView: liveUserLocationButton)
        
        ContainerView.anchor(top: searchTextFeild.safeAreaLayoutGuide.bottomAnchor,
                             left: view.leftAnchor,
                             bottom: view.bottomAnchor,
                             right: view.rightAnchor,
                             paddingTop: 32.0,
                             paddingLeft: 0.0,
                             paddingRight: 0.0,
                             cornerRadius: 25)
        
        searchListCollectionView.anchor(top: ContainerView.topAnchor,
                                      left: ContainerView.leftAnchor,
                                      bottom: ContainerView.bottomAnchor,
                                      right: ContainerView.rightAnchor,
                                      paddingTop: 24.0,
                                      paddingLeft: 0.0,
                                      paddingRight: 0.0,
                                      cornerRadius: 0.0)
        
        activityIndactor.center = view.center
        print("✅ SearchView : setup UILayouts Completed.")
    }
    
    // MARK: Setup UI Event
    private func setupUIEvent(){
        print("✅ SearchView : setup UIEvent Completed.")
        liveUserLocationButton.addTarget(self, action: #selector(searchViewCloseButtonTapped(sender:)), for: .touchUpInside)
        searchTextFeild.delegate = self
    }
    
    // MARK: Close View
    @objc private func searchViewCloseButtonTapped(sender:UIButton){
        if sender.tag == 1{
            closeSearchView()
        }else{
            viewModel.delegate?.cameraMoveToUserLocation()
        }
    }
    
    // MARK: setup Collection View
    fileprivate func setupCollectionView(){
        // Register Search List Cell Custom Class using cell identifire
        searchListCollectionView.register(SearchCollectionViewCell.self, forCellWithReuseIdentifier: ListCellIdentifire)
        print("🔹 SearchView : collection view registered.")
    }

}
