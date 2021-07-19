//
//  DataTaskService.swift
//  NeshanNav
//
//  Created by Hoorad Ramezani on 7/19/21.
//

import Foundation

// MARK: Data Task Delegate
protocol DataTaskDelegate: AnyObject {
    typealias Response = ((Result<Data,Error>) -> Void)
    func StartDataTask(_ request: URLRequest,completion: @escaping Response)
    func CancelDataTask()
}

final class DataTaskService: DataTaskDelegate{
        
    //MARK: Dependency Injection
    private var session : URLSession
    init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    
    //MARK: Properties
    private var task: URLSessionTask?
    
    //MARK: StartDataTask
    /// This Function Make Data Task With URLRequest
    ///
    /// - Parameter request: URLRequest for data task
    func StartDataTask(_ request: URLRequest, completion: @escaping Response) {
        NetworkLogger.log(request: request)
        task = session.dataTask(with: request,
                                completionHandler: { [weak self] (data, response, error) in
                                    
            // MARK: 1. Check error
            if let error = error {
                completion(.failure(error))
            }
            
            // MARK: 2. Check response
            guard let response = response as? HTTPURLResponse else {
                completion(.failure(NetworkError.FragmentResponse))
                return
            }
                                    
            // MARK: 3. Validate Response
            self?.ValidateResponse(response, data: data) { result in
                completion(result)
            }
        })
        
        // MARK: Start Task
        task?.resume()
    }
    
    //  MARK: Cancel Task
    /// This Function Cancel Task
    func CancelDataTask() {
        // MARK: Cancel Data Task
        task?.cancel()
    }
    
}

extension DataTaskService{
    
    //  MARK: Validate Response
    /// This Function Validate HTTPURLResponse and Check Data != nil
    private func ValidateResponse(_ Response: HTTPURLResponse,data:Data?,completion:(Result<Data,Error>) -> Void) {
        switch Response.statusCode {
        case 200...299:
            guard let data = data else {
                completion(.failure(NetworkError.noData))
                return
            }
            completion(.success(data))
        case 470:
            completion(.failure(NetworkError.CoordinateParseError))
        case 480:
            completion(.failure(NetworkError.KeyNotFound))
        case 481:
            completion(.failure(NetworkError.LimitExceeded))
        case 482:
            completion(.failure(NetworkError.RateExceeded))
        case 483:
            completion(.failure(NetworkError.ApiKeyTypeError))
        case 484:
            completion(.failure(NetworkError.ApiWhiteListError))
        case 485:
            completion(.failure(NetworkError.ApiServiceListError))
        case 500:
            completion(.failure(NetworkError.GenericError))
        default:
            completion(.failure(NetworkError.serverSideError))
        }
    }
}
