//
//  GitHubReposTests.swift
//  GitHubReposTests
//
//  Created by Vijay Guruju on 28/11/20.
//  Copyright © 2020 V2Apps. All rights reserved.
//

import XCTest
@testable import GitHubRepos

class GitHubReposTests: XCTestCase {

    var session:URLSession!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        session = URLSession(configuration: .default)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        session = nil
    }

    
    //API test
    func testValidReposAPIResponse(){
        let language = "swift"
          let url = URL(string: "https://api.github.com/search/repositories?q=language:\(language)")
          let expect = expectation(description: "Status code: 200 or 201")
          
          let dataTask = session.dataTask(with: url!){data,response,error in
              
              if let error = error{
                  XCTFail("Error: \(error.localizedDescription)")
                  return
              }else if let statusCode = (response as? HTTPURLResponse)?.statusCode{
                  if statusCode == 200 || statusCode == 201{
                      expect.fulfill()
                      return
                  }
                  else{
                      XCTFail("Status code: \(statusCode)")                }
              }
              
              
          }
          dataTask.resume()

          wait(for: [expect], timeout: 5)
        
        
    }
    //API test for contributors API
       func testValidContributorsAPIResponse(){
           
          let url = URL(string: Constants.contributorsUrl )
          let expect = expectation(description: "Status code: 200 or 201")
          
          let dataTask = session.dataTask(with: url!){data,response,error in
              
              if let error = error{
                  XCTFail("Error: \(error.localizedDescription)")
                  return
              }else if let statusCode = (response as? HTTPURLResponse)?.statusCode{
                  if statusCode == 200 || statusCode == 201{
                      expect.fulfill()
                      return
                  }
                  else{
                      XCTFail("Status code: \(statusCode)")                }
              }
              
              
          }
          dataTask.resume()

          wait(for: [expect], timeout: 5)
           
       }
    //Issues Url test
    func testValidIssueUrlSplit(){
        let issueUrl = Constants.issuesUrl // issue url for Objective c AFNetworking Repo as example
        let responseIssueUrl = "https://api.github.com/repos/AFNetworking/AFNetworking/issues{/number}"
        let updatedIssueUrl = responseIssueUrl.getUpdatedIssuesUrlString()
        
        XCTAssertEqual(updatedIssueUrl, issueUrl)
        
    }
    

}
