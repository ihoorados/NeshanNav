//
//  DistanceMatrixRepository.swift
//  NeshanNav
//
//  Created by Hoorad Ramezani on 7/19/21.
//

import Foundation
import Foundation

protocol DistanceMatrixRepository {
    typealias FetchCompletion = (Result<DistanceMatrixModel, NetworkError>) -> Void
    func getDistanceMatrixOverNetwork(pointA:NTLngLat,PointB:NTLngLat,_ completion: @escaping FetchCompletion)
}

struct DistanceMatrixRepositoryImp: DistanceMatrixRepository {
    
    private var Service:DataTaskDelegate
    init(service:DataTaskDelegate = DataTaskService()) {
        Service = service
    }

    func getDistanceMatrixOverNetwork(pointA:NTLngLat,PointB:NTLngLat,_ completion: @escaping FetchCompletion){
        
        // Create endPoint
        let endPoint = HTTPRequest(path: "/v1/distance-matrix", host: "api.neshan.org", scheme: "https",
                              method: HTTPMethod.get.rawValue,
                              headers: HTTPHeaders(["Api-Key":"\(API_KEY)"]),
                              parameter: HTTPParameters(["origins":"\(pointA.getY()),\(pointA.getX())",
                                                         "destinations":"\(PointB.getY()),\(PointB.getX())"]))
        
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
                .decode(FailableDecodable<DistanceMatrixModel>.self, from: data)
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
