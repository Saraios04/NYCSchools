//
//  SchoolListRequest.swift
//  NYCSchools
//
//  Created by Sara on 16/12/22.
//

import UIKit

class SchoolListRequest: NYCRequest {
    
    private var baseUrl : String?
    convenience init(baseUrl: String) {
        self.init()
        self.baseUrl = baseUrl
    }
    override func endPoint() -> String {
        guard let bUrl = baseUrl else {
            return ""
        }
        return bUrl + Constants.API.SCHOOL_LIST_API
    }
    override func requestMethod() -> RequestMethod {
        return .get
    }
}
