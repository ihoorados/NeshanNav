//
//  SearchViewTextFieldDelegate.swift
//  NeshanNav
//
//  Created by Hoorad Ramezani on 7/19/21.
//


import Foundation

extension SearchView: UITextFieldDelegate{
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        openSearchView()
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard let text = textField.text else {
            return
        }
        isLoading(_ status: true)
        viewModel.requestForSearchingLocation(term: text)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
      closeSearchView()
      return true
    }
}
