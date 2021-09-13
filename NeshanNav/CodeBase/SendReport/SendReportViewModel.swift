//
//  SendReportViewModel.swift
//  NeshanNav
//
//  Created by Hoorad Ramezani on 12/9/21.
//

import Foundation

protocol SendReportViewModel: AnyObject {
    var items: [ReportType] { get set }
}

class SendReportViewModelImpl: SendReportViewModel {
    
    var items: [ReportType]
    
    init() {
        items = [ReportType.init()]
    }
}
