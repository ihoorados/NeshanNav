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
        
        self.items = [ReportType.init(text: "Accident", image: "report_event_1"),
                      ReportType.init(text: "Camera", image: "report_event_2"),
                      ReportType.init(text: "Traffic", image: "report_event_3"),
                      ReportType.init(text: "Map bugs", image: "report_event_4"),
                      ReportType.init(text: "Speed bump", image: "report_event_5"),
                      ReportType.init(text: "Cop", image: "report_event_6"),
                      ReportType.init(text: "Atmospheric", image: "report_event_7"),
                      ReportType.init(text: "Path events", image: "report_event_8"),
                      ReportType.init(text: "Locations", image: "report_event_9")]
    }
     
    init(items: [ReportType]) {
        self.items = items
    }
}


extension SendReportViewModelImpl{
    
    func mainCollectionReportList() -> [ReportType]{
        return [ReportType.init(text: "Accident", image: "report_event_1"),
                ReportType.init(text: "Camera", image: "report_event_2"),
                ReportType.init(text: "Traffic", image: "report_event_3"),
                ReportType.init(text: "Map bugs", image: "report_event_4"),
                ReportType.init(text: "Speed bump", image: "report_event_5"),
                ReportType.init(text: "Cop", image: "report_event_6"),
                ReportType.init(text: "Atmospheric", image: "report_event_7"),
                ReportType.init(text: "Path events", image: "report_event_8"),
                ReportType.init(text: "Locations", image: "report_event_9")]
    }
    

    
    
}
