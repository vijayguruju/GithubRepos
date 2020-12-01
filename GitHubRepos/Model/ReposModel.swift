//
//  ReposModel.swift
//  GitHubRepos
//
//  Created by Vijay Guruju on 28/11/20.
//  Copyright © 2020 V2Apps. All rights reserved.
//

import Foundation


struct Repository:Codable {
    var name :String
    var description : String?
    var contributors_url : String
    var issues_url:String

}
//repositories
struct Repositories:Codable {
    var items : [Repository]
}

// contributors
struct Contributor:Codable {
    var login :String
    
}

//issues
struct Issue:Codable {
    var title :String
}


