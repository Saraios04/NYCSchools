//
//  Constants.swift
//  NYCSchools
//
//  Created by Sara on 16/12/22.
//

import UIKit

struct Constants {
    
    struct API {
           static let BASE_URL = "https://data.cityofnewyork.us/resource"
           static let SCHOOL_LIST_API = "/s3k6-pzi2.json"
           static let SAT_LIST_API = "/f9bf-2cp4.json"
    }
    struct ErrorMessage {
        public static let INTERNET_CONNECTIVITY = "No Internet Connection"
        public static let SOMETHING_WENT_WRONG = "Sorry, We could not process your request"

    }
}
