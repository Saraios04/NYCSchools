//
//  NYCSchoolViewModel.swift
//  NYCSchools
//
//  Created by Sara on 16/12/22.
//

import UIKit

open class NYCSchoolViewModel: NSObject {
    
    var baseUrl : String?
    public var status_code = 0
    public var errorMsg:String?
    
    init(withBaseUrl baseUrl : String) {
        self.baseUrl = baseUrl
    }
    func getSchoolDetail( completion:@escaping(Result<NYCSchoolListModel, ErrorType>) -> Void){
        
        guard let url = self.baseUrl else {
            return
        }
        let request = SchoolListRequest(baseUrl: url)
        NetworkManager.shared.request(request: request , completion: {
             (result) in
            
            switch result {
            case .success((_ , let data)):
                if data != nil {
                    if let json = try? JSONSerialization.jsonObject(with: data!, options: []) as? [[String : Any]] {
                         let schoolList = NYCSchoolListModel(data: json)
                         completion(.success(schoolList))
                    }
                }
            case .failure(let error, (_ , let data)) :
                if let jsonData = data {
                    do {
                        let errorModel = try JSONDecoder().decode(ErrorModel.self, from: jsonData)
                        if let errorMsg = errorModel.error {
                            self.errorMsg = errorMsg
                        }else {
                            self.errorMsg =  errorModel.message ?? ""
                            completion(.failure(.apiError))
                        }
                        completion(.failure(.apiError))
                    } catch {
                        completion(.failure(.apiError))
                    }
                }
            if error == .apiError{
                completion(.failure(.apiError))
            }
            else if error == .notReachable {
                completion(.failure(.notReachable))
            }else {
                completion(.failure(.networkError))
            }
        }
        
        })
    }
    
    func getSATSchoolData( completion:@escaping(Result<SATSchoolDataModel, ErrorType>) -> Void){
        
        guard let url = self.baseUrl else {
            return
        }
   
        let request = SATSchoolRequest(baseUrl: url)
        NetworkManager.shared.request(request: request, completion: {  (result) in
   
            switch result {
            case .success((_ , let data)):
                if data != nil {
                    if let json = try? JSONSerialization.jsonObject(with: data!, options: []) as? [[String : Any]] {
                         let schoolList = SATSchoolDataModel(data: json)
                         completion(.success(schoolList))
                    }
                }
            case .failure(let error, ( _ , let data)) :
                
                    if let jsonData = data {
                        do {
                            let errorModel = try JSONDecoder().decode(ErrorModel.self, from: jsonData)
                            if let errorMsg = errorModel.error {
                                self.errorMsg = errorMsg
                            }else {
                                self.errorMsg =  errorModel.message ?? ""
                                completion(.failure(.apiError))
                            }
                            completion(.failure(.apiError))
                        } catch {
                            completion(.failure(.apiError))
                        }
                    }
                if error == .apiError{
                    completion(.failure(.apiError))

                }
                else if error == .notReachable {
                    completion(.failure(.notReachable))
                }else {
                    completion(.failure(.networkError))
                }
            }
        })
        
    }
}
