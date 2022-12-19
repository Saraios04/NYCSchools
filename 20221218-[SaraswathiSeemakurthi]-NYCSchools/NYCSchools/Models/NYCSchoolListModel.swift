//
//  NYCSchoolListModel.swift
//  NYCSchools
//
//  Created by Sara on 16/12/22.
//

import UIKit


class NYCSchoolListModel : NSObject{
    var schoolListArray = [SchoolDetail]()
    init(data: [[String :Any]]) {
        for item in data {
            let schoolDetail = SchoolDetail(item: item)
            schoolListArray.append(schoolDetail)
        }
    }
     
}

class SchoolDetail : NSObject {
    var dbn: String?
    var school_name: String?
    var overview_paragraph: String?
    var total_students: String?
    init(item : [String:Any]) {
        if let dbn = item["dbn"] as? String{
            self.dbn = dbn
        }
        if let school_name = item["school_name"] as? String{
            self.school_name = school_name
        }
        if let overview_paragraph = item["overview_paragraph"] as? String{
            self.overview_paragraph = overview_paragraph
        }
        if let total_students = item["total_students"] as? String{
            self.total_students = total_students
        }
        
    }
}


