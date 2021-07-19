//
//  BillboardUseCases.swift
//  NeshanNav
//
//  Created by Hoorad Ramezani on 7/19/21.
//

import Foundation

protocol BilboardUseCases: AnyObject {
    func billboardChangetTo(height: CGFloat)
    var CTATapped: (() -> Void)? { get set }
    var ExitTapped: (() -> Void)? { get set }
}
