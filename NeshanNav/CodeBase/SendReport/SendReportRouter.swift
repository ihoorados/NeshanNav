//
//  SendReportRouter.swift
//  NeshanNav
//
//  Created by Hoorad Ramezani on 13/9/21.
//


import Foundation

final class SendReportRouter: SendReportUseCases{
    
    /* ////////////////////////////////////////////////////////////////////// */
    // MARK: Dependency Injection
    /* ////////////////////////////////////////////////////////////////////// */
    
    weak var delegate: BoardUIDelegate?
    private let viewModel: SendReportViewModel
    
    init(viewModel:SendReportViewModel) {
        
        self.viewModel = viewModel
    }
    
    deinit {
        print("🗑 SendReportRouter: deinit frome memory.")
    }
    
    /* ////////////////////////////////////////////////////////////////////// */
    // MARK: Functions
    /* ////////////////////////////////////////////////////////////////////// */
    
    func select(item: ReportType) {
        delegate?.BoardRouteTo(item: item)
    }
}
