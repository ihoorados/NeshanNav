//
//  SendReportUseCases.swift
//  NeshanNav
//
//  Created by Hoorad Ramezani on 13/9/21.
//

import Foundation


struct ReportType {
    let item: String = ""
}

protocol SendReportUseCases: AnyObject  {
    func select(item: ReportType)
}


