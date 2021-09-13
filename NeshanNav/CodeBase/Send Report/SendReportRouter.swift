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
    
    init() { }
    
    deinit {
        print("🗑 SendReportRouter: deinit frome memory.")
    }
    
    /* ////////////////////////////////////////////////////////////////////// */
    // MARK: Functions
    /* ////////////////////////////////////////////////////////////////////// */
    
    func select(item: ReportType) {
        print(item)
        delegate?.BoardRouteTo(item: item)
    }
}
