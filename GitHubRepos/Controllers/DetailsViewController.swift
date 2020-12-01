//
//  DetailsViewController.swift
//  GitHubRepos
//
//  Created by Vijay Guruju on 28/11/20.
//  Copyright © 2020 V2Apps. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var descLbl: UILabel!
    @IBOutlet weak var issuesLbl: UILabel!
    @IBOutlet weak var contributorsLbl: UILabel!
    
    var name  = ""
    var desc = ""
    var issuesUrl = ""
    var contributorsUrl = ""
    var contributors = [Contributor]()
    var issues = [Issue]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.nameLbl.text = name
        self.descLbl.text = desc
        
        getContribtorsAndIssues(url: &issuesUrl, fromIssues: true)
        getContribtorsAndIssues(url: &contributorsUrl, fromIssues: false)
        
    }
    
//MARK:-  Contributors and Issues API
    func getContribtorsAndIssues(url: inout String,fromIssues:Bool){
        
        if fromIssues{
            //url = url.components(separatedBy: "{")[0] // as issues api url is not coming as required separating it with { then taking first (required) string
            url = url.getUpdatedIssuesUrlString()
        }
        guard let reqUrl = URL(string: url) else { return  }
               
               let session = URLSession.shared
               let task = session.dataTask(with: reqUrl, completionHandler: {(data,error,response) -> Void in

                   let decoder = JSONDecoder()

                   if let responseData = data {
                    
                    if !fromIssues{ //contributors
                       if let json = try? decoder.decode([Contributor].self, from: responseData){
                           self.contributors = json
                           //print(json)
                            var updatedContributors = [String]()
                            for ( index,contributor )in self.contributors.enumerated(){
                                if index <= 2{//taking only required value i.e 3
                                    updatedContributors.append("\(index + 1). " + contributor.login)
                                }
                            }
                           DispatchQueue.main.async {//Updating UI with contributors response
                                self.contributorsLbl.text = "Top 3 contributors:\n" +  updatedContributors.joined(separator: "\n")
                           }
                       }
                    }
                    else{//issues
                        if let json = try? decoder.decode([Issue].self, from: responseData){
                            self.issues = json
                            //print(json)
                             var updatedIssues = [String]()
                             for ( index,issue )in self.issues.enumerated(){
                                 if index <= 2{//taking only required value i.e 3
                                    updatedIssues.append("\(index + 1). " + issue.title)
                                 }
                             }
                            
                            DispatchQueue.main.async {//Updating UI with Issues response
                                self.issuesLbl.text = "Newest issues:\n" +  updatedIssues.joined(separator: "\n")
                            }
                        }
                    }

                   }
              })
            task.resume()
    }
    
    
}

extension String{
    func getUpdatedIssuesUrlString() ->String{
        return  self.components(separatedBy: "{")[0]
        
    }
}



