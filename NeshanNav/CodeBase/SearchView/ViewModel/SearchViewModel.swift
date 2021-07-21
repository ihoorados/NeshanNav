//
//  SearchViewModel.swift
//  NeshanNav
//
//  Created by Hoorad Ramezani on 7/21/21.
//

import Foundation

protocol SearchViewModel {
    func selectAddress(at indexPath: IndexPath)
    func requestForSearchingLocation(term: String)
    var listItem : [SearchItem] { get set }
    var retryRequest: (() -> ())? { get set }
    var delegate: SearchUseCases? { get set }
    var searchViewDelegate: SearchViewDelegate? { get set }
}
