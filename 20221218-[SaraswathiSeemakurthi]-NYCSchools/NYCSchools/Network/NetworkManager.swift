//
//  NetworkManager.swift
//  NYCSchools
//
//  Created by Sara on 15/12/22.
//

import UIKit

enum QueryResult<Element> {
    case success(Element)
    case failure(ErrorType, Element)
}
enum ErrorStatus: String {
    case SUCCESS = "0"
    case ES_1 = "1"
    case ES_2 = "2"
}
enum NetworkError : Error {
    case unauthorised
    case timeout
    case serverError
    case invalidResponse
    case invalidUrl
}
enum ErrorType: Int, Error {
    case apiError
    case networkError
    case notReachable
    case timeOut
    case noInternet
}
enum RequestMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
    case patch = "PATCH"
    var acceptsBody : Bool {
        switch self {
        case .post, .put :
            return true
        default:
            return false
        }
    }
}
class NetworkManager: NSObject {
    
    typealias NetworkResult = QueryResult <(URLResponse, Data?)>
    static let shared = NetworkManager()
    override init() {
        super.init()
    }
    func request(request: NYCRequest, queryItems: [URLQueryItem] = [], completion: ((NetworkResult) -> Void)? = nil) {
        
        let buildRequest = buildRequest(request: request, queryItems: queryItems)
        
        URLSession.shared.dataTask(with: buildRequest as URLRequest) { (data, response, error) in
            
            let jsonData:Data?
            if let httpResponse = response as? HTTPURLResponse {
                do {
                    if data != nil {
                        if let json = try? JSONSerialization.jsonObject(with: data!, options: []) as? [[String : Any]] {
                            let data = try JSONSerialization.data(withJSONObject: json, options: [])
                            if let string = String(data: data, encoding: String.Encoding.utf8) {
                                jsonData = string.data(using: .utf8)
                                switch httpResponse.statusCode {
                                case 200...299:
                                    if let response = response {
                                        completion?(.success((response,jsonData)))
                                        return
                                    }
                                default:
                                    if let response = response {
                                        completion?(.failure(ErrorType.apiError, (response, jsonData)))
                                    }
                                }
                            }
                        }
                    }
                } catch {
                    if let response = response {
                        completion?(.failure(ErrorType.networkError, (response, nil)))
                    }
                }
            }else{
                if (error != nil) {
                    switch (error as? URLError)?.code {
                    case URLError.Code.timedOut:
                        completion?(.failure(ErrorType.timeOut, (URLResponse.init(), nil)))
                    case .none:
                        break
                    case .some(_):
                        break
                    }
                }
            }
        }.resume()
    }
    private func buildRequest(request: NYCRequest, queryItems: [URLQueryItem] = []) -> URLRequest {
        
        var url = URL(string: request.endPoint())!
        if !queryItems.isEmpty, var components = URLComponents(url: url, resolvingAgainstBaseURL: true) {
            components.queryItems = queryItems
            if let modifiedURL = components.url {
                url = modifiedURL
            }
        }
        var tmpRequest = URLRequest(url: url)
        tmpRequest.httpMethod = request.requestMethod().rawValue
        tmpRequest.timeoutInterval = 30
        tmpRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        if let param = request.paramDict, let body = try? JSONSerialization.data(withJSONObject: param, options: []) {
            tmpRequest.httpBody = body
        }
        if let paramData = request.paramData {
            tmpRequest.httpBody = paramData
        }
        return tmpRequest
    }
}
