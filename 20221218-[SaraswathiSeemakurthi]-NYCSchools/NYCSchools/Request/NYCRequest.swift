//
//  NYCRequest.swift
//  NYCSchools
//
//  Created by Sara on 15/12/22.
//

import UIKit

class NYCRequest: NetworkManager {
    
    var paramDict: [AnyHashable: Any]?
    var paramData: Data?
    func endPoint() -> String {
        preconditionFailure("")
    }
    func requestMethod() -> RequestMethod {
        preconditionFailure("")
    }
}
