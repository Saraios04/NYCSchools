//
//  NYCSchoolListTest.swift
//  NYCSchoolsTests
//
//  Created by Sara on 18/12/22.
//

import XCTest
@testable import NYCSchools

class NYCSchoolListTest: XCTestCase {

    var nycModel: NYCSchoolViewModel? = nil
    override func setUpWithError() throws {
        URLSession.injectProxy()
        nycModel = NYCSchoolViewModel(withBaseUrl: Constants.API.BASE_URL)
        MockUrlProtocol.clear()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        nycModel = nil
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_ForRequest() {
        let endPoint = URL(string: Constants.API.BASE_URL)
        XCTAssertTrue(endPoint?.scheme == "https")
        XCTAssertTrue(endPoint?.host == "data.cityofnewyork.us")
    }
    func test_ifGetSchoolListAvailable(){
        let bundle = Bundle(for: type(of: self))
        let path = bundle.path(forResource: "NYCSchoolListResponse", ofType: "json")
        let jsonData = try! String(contentsOfFile: path!).data(using: .utf8)
        
        let expetations = XCTestExpectation(description: "view model to call the list api of school for result")
        
        MockUrlProtocol.handleRequest = { request in
            return .init(result: .success(jsonData!))
        }
       
        nycModel?.getSchoolDetail(completion: {  result in
            switch result {
            case .success(let data):
                if !data.schoolListArray.isEmpty {
                    XCTAssertEqual(data.schoolListArray.count > 0, true , "School List is available")
                }else {
                    XCTAssert(false)
                }
                
            case .failure(let error):
                XCTAssertEqual(error, ErrorType.apiError, "Parsing error was expected")
            }
            expetations.fulfill()
        })
    }
    
    func test_ifSchoolPresentInList(){
        let bundle = Bundle(for: type(of: self))
        let path = bundle.path(forResource: "NYCSchoolListResponse", ofType: "json")
        let jsonData = try! String(contentsOfFile: path!).data(using: .utf8)
        
        let expetations = XCTestExpectation(description: "view model to call list api for school to find the  name of the school present in the list")
        MockUrlProtocol.handleRequest = { request in
            return .init(result: .success(jsonData!))
        }
        nycModel?.getSchoolDetail(completion: {  result in
            switch result {
            case .success(let data):
                    XCTAssertEqual(data.schoolListArray.contains(where: {$0.school_name == "Women's Academy of Exellence"}), true)
            case .failure(let error):
                XCTAssertEqual(error, ErrorType.apiError, "Parsing error was expected")
            }
            expetations.fulfill()
        })
    }
    
    func test_ifSATDataAvailableForSchool(){
        let bundle = Bundle(for: type(of: self))
        let path = bundle.path(forResource: "SATSchoolDetailResponse", ofType: "json")
        let jsonData = try! String(contentsOfFile: path!).data(using: .utf8)
        
        let expetations = XCTestExpectation(description: "view model to call the list api for SAT to find the school SAT result are present")
        MockUrlProtocol.handleRequest = { request in
            return .init(result: .success(jsonData!))
        }
        nycModel?.getSATSchoolData(completion: {  result in
            switch result {
            case .success(let data):
                    XCTAssertEqual(data.satSchoolDetailListArray.contains(where: {$0.dbn == "01M448"}), true, "SAT detail is present for dbn no")
            case .failure(let error):
                XCTAssertEqual(error, ErrorType.apiError, "Parsing error was expected")
            }
            expetations.fulfill()
        })
    }
    
    func test_ifSATDataNotPresent(){
        let bundle = Bundle(for: type(of: self))
        let path = bundle.path(forResource: "SATSchoolDetailResponse", ofType: "json")
        let jsonData = try! String(contentsOfFile: path!).data(using: .utf8)
        
        let expetations = XCTestExpectation(description: "view model to call the list api for SAT to find the school and the SAT result are not present")
        MockUrlProtocol.handleRequest = { request in
            return .init(result: .success(jsonData!))
        }
        nycModel?.getSATSchoolData(completion: {  result in
            switch result {
            case .success(let data):
                    XCTAssertNotEqual(data.satSchoolDetailListArray.contains(where: {$0.dbn == "01M292"}), true, "SAT detail is not present for dbn no")
            case .failure(let error):
                XCTAssertEqual(error, ErrorType.apiError, "Parsing error was expected")
            }
            expetations.fulfill()
        })
    }
    
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

}
