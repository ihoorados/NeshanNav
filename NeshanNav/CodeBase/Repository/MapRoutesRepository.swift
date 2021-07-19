//
//  MapRoutesRepository.swift
//  NeshanNav
//
//  Created by Hoorad Ramezani on 7/19/21.
//

import Foundation
protocol MapRoutesRepository {
    typealias RoutesFetchCompletion = (Result<Routes, NetworkError>) -> Void
    func getMockRouteInfo(pointA:NTLngLat,pointB:NTLngLat,_ completion: @escaping RoutesFetchCompletion)
    func getRouteInfoOverNetwork(pointA:NTLngLat,PointB:NTLngLat,_ completion: @escaping RoutesFetchCompletion)
}

struct MapRoutesRepositoryImp: MapRoutesRepository {
    
    private var Service:DataTaskDelegate
    init(service:DataTaskDelegate = DataTaskService()) {
        Service = service
    }

    func getRouteInfoOverNetwork(pointA:NTLngLat,PointB:NTLngLat,_ completion: @escaping RoutesFetchCompletion){
        
        // Create endPoint
        let endPoint = HTTPRequest(path: "/v3/direction", host: "api.neshan.org", scheme: "https",
                              method: HTTPMethod.get.rawValue,
                              headers: HTTPHeaders(["Api-Key":"\(API_KEY)"]),
                              parameter: HTTPParameters(["origin":"\(pointA.getY()),\(pointA.getX())",
                                                         "destination":"\(PointB.getY()),\(PointB.getX())","type":"car"]))
        
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
    
    
    func getMockRouteInfo(pointA:NTLngLat,pointB:NTLngLat,_ completion: @escaping RoutesFetchCompletion) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.parseJSON { result in
                completion(result)
            }
        }
    }
    
    // MARK: Mock JSON Route
    private func parseJSON(completion: @escaping RoutesFetchCompletion){
            guard let path = Bundle.main.path(forResource: "route", ofType: "json") else{ return }
            let url = URL(fileURLWithPath: path)
            do{
                let data = try Data(contentsOf: url)
                let response = try JSONDecoder().decode(Routes.self, from: data)
                completion(.success(response))
            }catch{
                debugPrint(error)
                completion(.failure(.failed))
            }
    }
    
    // Mark: - Decode Profile Data And Update Status
    private func JSONSerializationWith(data: Data,completion: RoutesFetchCompletion) {
        do {
            let DataModel = try JSONDecoder()
                .decode(FailableDecodable<Routes>.self, from: data)
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


struct FailableDecodable<Base : Decodable> : Decodable {
    let base: Base?
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        self.base = try? container.decode(Base.self)
    }
}
