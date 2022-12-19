//
//  NetworkExtension.swift
//  NYCSchoolsTests
//
//  Created by Sara on 18/12/22.
//

import Foundation
extension URLSession {
    static func injectProxy() {
        #if DEBUG
        URLProtocol.registerClass(MockUrlProtocol.self)
        URLSession.shared.configuration.protocolClasses = [MockUrlProtocol.self]
        #endif
    }
}
extension URLResponse {
    static func statusCode(_ code: Int) -> HTTPURLResponse {
        return HTTPURLResponse (
            url: .init(string : "google.com")!,
            statusCode : code,
            httpVersion:nil,
            headerFields : nil
        )!
    }
}
