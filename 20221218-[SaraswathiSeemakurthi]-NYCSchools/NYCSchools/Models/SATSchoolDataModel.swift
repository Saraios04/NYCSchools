//
//  SATSchoolDataModel.swift
//  NYCSchools
//
//  Created by Sara on 16/12/22.
//

import Foundation

class SATSchoolDataModel : NSObject{
    var satSchoolDetailListArray = [SATDetail]()
    init(data: [[String :Any]]) {
        for item in data {
            let satDetail = SATDetail(item: item)
            satSchoolDetailListArray.append(satDetail)
        }
    }
     
}

class SATDetail : NSObject {
    var dbn : String?
    var num_of_sat_test_takers : String?
    var sat_critical_reading_avg_score : String?
    var sat_math_avg_score : String?
    var sat_writing_avg_score : String?
    var school_name : String?
    init(item : [String:Any]) {
        if let dbn = item["dbn"] as? String{
            self.dbn = dbn
        }
        if let num_of_sat_test_takers = item["num_of_sat_test_takers"] as? String{
            self.num_of_sat_test_takers = num_of_sat_test_takers
        }
        if let sat_critical_reading_avg_score = item["sat_critical_reading_avg_score"] as? String{
            self.sat_critical_reading_avg_score = sat_critical_reading_avg_score
        }
        if let sat_math_avg_score = item["sat_math_avg_score"] as? String{
            self.sat_math_avg_score = sat_math_avg_score
        }
        if let sat_writing_avg_score = item["sat_writing_avg_score"] as? String{
            self.sat_writing_avg_score = sat_writing_avg_score
        }
        if let school_name = item["school_name"] as? String{
            self.school_name = school_name
        }
        
    }
}

