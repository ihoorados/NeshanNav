//
//  ReportCollectionView.swift
//  NeshanNav
//
//  Created by Hoorad Ramezani on 13/9/21.
//

import Foundation
import UIKit

class ReportCollectionView: UIViewController {
    
    /* ////////////////////////////////////////////////////////////////////// */
    // MARK: Dependency Injection
    /* ////////////////////////////////////////////////////////////////////// */
    
    var viewModel: SendReportViewModel
    var delegate: SendReportUseCases
    
    init(delegate: SendReportUseCases, viewModel: SendReportViewModel) {
        self.delegate = delegate
        self.viewModel = viewModel
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
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        setupUIView()
        setupUILayout()
        setupCollectionView()
    }
    
    
    /* ////////////////////////////////////////////////////////////////////// */
    // MARK: UI Properties
    /* ////////////////////////////////////////////////////////////////////// */

    
    let cellIdentifire = "cellIdentifire"
    var reportBoxCollectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 8.0
        layout.minimumInteritemSpacing = 8.0
        let CollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        CollectionView.translatesAutoresizingMaskIntoConstraints = false
        CollectionView.showsVerticalScrollIndicator = false
        CollectionView.showsHorizontalScrollIndicator = false
        CollectionView.backgroundColor = .clear
        return CollectionView
    }()
    
    /* ////////////////////////////////////////////////////////////////////// */
    // MARK: Setup Function
    /* ////////////////////////////////////////////////////////////////////// */
    
    private func setupUIView() {
        self.view.addSubview(reportBoxCollectionView)
    }
    
    private func setupUILayout(){

        reportBoxCollectionView.anchor(top: self.view.topAnchor,
                                       left: self.view.leftAnchor,
                                       bottom: self.view.bottomAnchor,
                                       right: self.view.rightAnchor)
        
    }
    
    private func setupCollectionView() {
        reportBoxCollectionView.register(ReportItemsCell.self, forCellWithReuseIdentifier: cellIdentifire)
        reportBoxCollectionView.register(SectionHeaderCell.self,
                                          forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                          withReuseIdentifier: "headerView")
        reportBoxCollectionView.dataSource = self
        reportBoxCollectionView.delegate = self
        
    }
    

}
