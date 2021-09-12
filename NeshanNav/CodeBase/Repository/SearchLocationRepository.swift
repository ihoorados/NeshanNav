//
//  SearchLocationRepository.swift
//  NeshanNav
//
//  Created by Hoorad Ramezani on 7/19/21.
//


import Foundation

protocol SearchLocationRepository {
    typealias FetchCompletion = (Result<SearchLocationModel, NetworkError>) -> Void
    func getLocationsOverNetwork(at location:Location,term:String,_ completion: @escaping FetchCompletion)
}

struct SearchLocationRepositoryImpl: SearchLocationRepository {
    
    private var Service:DataTaskDelegate
    init(service:DataTaskDelegate = DataTaskService()) {
        Service = service
    }

    func getLocationsOverNetwork(at location:Location,term:String,_ completion: @escaping FetchCompletion){
        
        Service.CancelDataTask()
        
        // Create endPoint
        let endPoint = HTTPRequest(path: "/v1/search", host: "api.neshan.org", scheme: "https",
                              method: HTTPMethod.get.rawValue,
                              headers: HTTPHeaders(["Api-Key":"\(API_KEY)"]),
                              parameter: HTTPParameters(["term":"\(term)",
                                                         "lat":"\(location.latitude)",
                                                         "lng":"\(location.longitude)"]))
        
        guard let url = endPoint.buildURL() else {
            return
        }
        let request = endPoint.buildURLRequest(with: url)
        Service.StartDataTask(request) { result in
            switch result{
                case .success(let responseData):
                    JSONSerializationWith(data: responseData) { result in
                        completion(result)
                    }
            case .failure(_):
                    completion(.failure(.failed))
            }
        }
    }
    
    // Mark: - Decode Profile Data And Update Status
    private func JSONSerializationWith(data: Data,completion: FetchCompletion) {
        do {
            let DataModel = try JSONDecoder()
                .decode(FailableDecodable<SearchLocationModel>.self, from: data)
                .base
            guard let model = DataModel else {
                completion(.failure(.decodingFailed))
                return
            }
            completion(.success(model))
        } catch let jsonError as NSError {
          print("JSON decode failed: \(jsonError.localizedDescription)")
            completion(.failure(.decodingFailed))
        }
    }
    
}
