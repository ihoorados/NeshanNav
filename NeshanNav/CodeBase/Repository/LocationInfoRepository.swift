//
//  LocationInfoRepository.swift
//  NeshanNav
//
//  Created by Hoorad Ramezani on 7/19/21.
//

import Foundation

protocol LocationInfoRepository {
    typealias FetchCompletion = (Result<RouteModel, NetworkError>) -> Void
    func getLocationInfoOverNetwork(at location:Location,_ completion: @escaping FetchCompletion)
    func getMockRouteInformation(at location: Location, _ completion: @escaping FetchCompletion)
}

struct LocationInfoRepositoryImpl: LocationInfoRepository {
    
    private var Service:DataTaskDelegate
    init(service:DataTaskDelegate = DataTaskService()) {
        Service = service
    }
    
    func getLocationInfoOverNetwork(at location:Location,_ completion: @escaping FetchCompletion){
        
        // Create endPoint
        let endPoint = HTTPRequest(path: "/v2/reverse", host: "api.neshan.org", scheme: "https",
                              method: HTTPMethod.get.rawValue,
                              headers: HTTPHeaders(["Api-Key":"\(API_KEY)"]),
                              parameter: HTTPParameters(["lat":"\(location.latitude)","lng":"\(location.longitude)"]))
        
        guard let url = endPoint.buildURL() else {
            return
        }
        let request = endPoint.buildURLRequest(with: url)
        
        // Make Data Task With Service
        Service.StartDataTask(request) { result in
            switch result{
                case .success(let responseData):
                    self.JSONSerializationWith(data: responseData) { result in
                        completion(result)
                    }
            case .failure(_):
                    completion(.failure(.dataTaskFailed))
            }
        }
    }
    
    func getMockRouteInformation(at location:Location,_ completion: @escaping FetchCompletion) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            completion(.success(MockRouteInformationModel))
        }
    }
    
    // Mark: - Decode Profile Data And Update Status
    private func JSONSerializationWith(data: Data,completion: FetchCompletion) {
        do {
            let DataModel = try JSONDecoder()
                .decode(FailableDecodable<RouteModel>.self, from: data)
                .base
            guard let model = DataModel else {
                completion(.failure(.encodingFailed))
                return
            }
            //let response = try JSONDecoder().decode(RouteModel.self, from: data)
            completion(.success(model))
        } catch let jsonError as NSError {
          print("JSON decode failed: \(jsonError.localizedDescription)")
            completion(.failure(.failed))
        }
    }
    

    
}
