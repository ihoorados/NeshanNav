//
//  EndPoint.swift
//  NeshanNav
//
//  Created by Hoorad Ramezani on 7/19/21.
//

import Foundation

public typealias HTTPParameters = [String: Any]?
public typealias HTTPHeaders    = [String: String]?

public enum HTTPMethod: String {
    case get     = "GET"
    case post    = "POST"
    case put     = "PUT"
    case delete  = "DELETE"
}

struct HTTPRequest{
    var path: String
    var host: String
    var scheme: String
    var method: HTTPMethod.RawValue
    var headers: HTTPHeaders
    var parameter: HTTPParameters
}

extension HTTPRequest{
    
    func buildURLRequest(with url: URL) -> URLRequest {
        var request = URLRequest(url: url)
        if let header = headers{
            for item in header{
                request.setValue(item.value, forHTTPHeaderField: item.key)
            }
        }
        return request
    }
        
    func buildURL() -> URL? {
        var component = URLComponents()
        component.scheme = scheme
        component.host = host
        component.path = path
        component.queryItems = getQurey()
        return component.url
    }
    
    func getQurey() -> [URLQueryItem] {
        var queryItems = [URLQueryItem]()
        if let parameter = parameter{
            for item in parameter{
                queryItems.append(URLQueryItem(name: item.key, value: item.value as? String))
            }
        }
        return queryItems
    }

    
}
