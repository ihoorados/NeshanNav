//
//  BillboardUseCases.swift
//  NeshanNav
//
//  Created by Hoorad Ramezani on 7/19/21.
//

import Foundation

protocol BilboardUseCases: AnyObject {
    func closeBillboard()
    func startNavigateOnMap()
    func findDirectionRoutes()
    func billboardHeightChangetTo(height: CGFloat)
}
