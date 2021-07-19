//
//  NetworkError.swift
//  NeshanNav
//
//  Created by Hoorad Ramezani on 7/19/21.
//

import Foundation

import Foundation

/// The enumeration defines possible errrors to encounter during Network Request
public enum NetworkError: String, Error {
    case parametersNil = "Error Found : Parameters are nil."
    case headersNil = "Error Found : Headers are Nil"
    case encodingFailed = "Error Found : Parameter Encoding failed."
    case decodingFailed = "Error Found : Unable to Decode the data."
    case missingURL = "Error Found : The URL is nil."
    case missingMethod = "Error Found : The Method is nil."
    case couldNotParse = "Error Found : Unable to parse the JSON response."
    case noData = "Error Found : The data from API is Nil."
    case FragmentResponse = "Error Found : The API's response's body has fragments."
    case UnwrappingError = "Error Found : Unable to unwrape the data."
    case dataTaskFailed = "Error Found : The Data Task object failed."
    case success = "Successful Network Request"
    case authenticationError = "Error Found : You must be Authenticated"
    case badRequest = "Error Found : Bad Request"
    case pageNotFound = "Error Found : Page/Route rquested not found."
    case failed = "Error Found : Network Request failed"
    case serverSideError = "Error Found : Server error"
    
    case CoordinateParseError = "Error : Coordinate Parse Error"
    case KeyNotFound = "Error Found : APIKey Not Found"
    case LimitExceeded = "Error Found : Limit Exceeded"
    case RateExceeded = "Error Found : RateExceeded"
    case GenericError = "Error Found : GenericError"
    case ApiKeyTypeError = "Error Found : ApiKeyTypeError"
    case ApiWhiteListError = "Error Found : ApiWhiteListError"
    case ApiServiceListError = "Error Found : ApiServiceListError"
}
