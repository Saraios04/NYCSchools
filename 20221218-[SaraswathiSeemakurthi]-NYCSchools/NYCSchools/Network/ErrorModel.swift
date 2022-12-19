//
//  ErrorModel.swift
//  NYCSchools
//
//  Created by Sara on 18/12/22.
//

import UIKit

struct ErrorModel:Codable {
    
    var message:String?
    var status_code:Int?
    var error:String?
    
    enum CodingKeys: String, CodingKey {
        case message, status_code, error
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status_code = try values.decode(Int.self, forKey: .status_code)
        message = try values.decode(String.self, forKey: .message)
        if let container = try? decoder.container(keyedBy: CodingKeys.self) {
            do {
                error = try container.decode(String.self, forKey: .error)
            } catch {
                if let errorDict = try? container.decode([String:String].self, forKey: .error) {
                    if !errorDict.values.isEmpty {
                        self.error = errorDict.values.first
                    }
                }
            }
        }
            
    }
}
