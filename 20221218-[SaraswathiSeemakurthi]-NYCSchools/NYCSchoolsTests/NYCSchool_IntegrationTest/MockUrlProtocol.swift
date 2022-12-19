//
//  MockUrlProtocol.swift
//  NYCSchoolsTests
//
//  Created by Sara on 18/12/22.
//

import Foundation
public class MockUrlProtocol : URLProtocol {
    static var contactedURLs = [URL]()
    static var shouldHandleRequest: ((URLRequest) -> Bool) = { _ in false}
    static var handleRequest: ((URLRequest) throws -> RequestHandler)?
    
    static func clear() {
        contactedURLs.removeAll()
        shouldHandleRequest = { _ in true}
        handleRequest = nil
    }
    public override class func canInit(with request: URLRequest) -> Bool {
        if let url = request.url {
            contactedURLs.append(url)
        }
        return shouldHandleRequest(request)
    }
    public override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    public override func startLoading() {
        guard let requestHandler = try? Self.handleRequest?(request) else {
            return
        }
        switch requestHandler.result {
        case .failure(let error):
            client?.urlProtocol(self, didFailWithError: error)
        case .success(let data):
            client?.urlProtocol(self, didReceive: requestHandler.response, cacheStoragePolicy: requestHandler.cacheStoragePolicy)
            client?.urlProtocol(self, didLoad: data)
            client?.urlProtocolDidFinishLoading(self)
        }
    }
    public override func stopLoading() {
        
    }
    
}
public extension MockUrlProtocol {
    struct RequestHandler {
        var cacheStoragePolicy: URLCache.StoragePolicy = .notAllowed
        var result: Result<Data, Error> = .success(.init())
        var response: HTTPURLResponse = .init()
        static let `default`: Self = .init()
    }
}
