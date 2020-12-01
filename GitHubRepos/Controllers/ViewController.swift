//
//  ViewController.swift
//  GitHubRepos
//
//  Created by Vijay Guruju on 28/11/20.
//  Copyright © 2020 V2Apps. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var languageTxt: UITextField!
    @IBOutlet weak var submitBtn: UIButton!
    var repositories = [Repository]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func submitBtnAction(_ sender: Any) {
        if self.languageTxt.text?.trimmingCharacters(in: .whitespaces).isEmpty != true{
                  //Get repos from entred language using GitHub API
                  getRepos(language: languageTxt.text!)
              }
              else
              {
                  //empty text field
                  self.showAlert(message: Constants.noLanguageMsg)
              }
    }
    
     
    //MARK:- Get repos from language name API
    func getRepos(language:String){
        
        guard let reqUrl = URL(string: (Constants.reposUrl + "\(language)")) else { return  }
        
        let session = URLSession.shared
        let task = session.dataTask(with: reqUrl, completionHandler: {(data,error,response) -> Void in

            let decoder = JSONDecoder()

            if let responseData = data {
                if let jsonRepos = try? decoder.decode(Repositories.self, from: responseData){
                    self.repositories = jsonRepos.items
                    print(self.repositories.count)
                    
                    DispatchQueue.main.async { // Navigate to list of repos after getttng
                    let reposVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ReposListTableViewController") as! ReposListTableViewController
                    reposVC.repositories = self.repositories
                    self.navigationController?.show(reposVC, sender: self)
                        
                    }
                } else{ //show alert for invalid language
                       DispatchQueue.main.async {
                        self.showAlert(message: Constants.validLanguageMsg)
                        
                    }
                   }
            }
           
       })
        
        task.resume()
    }
    
   //MARK:- Alert
    func showAlert(message:String){
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "OK", style: .cancel, handler:  {(action: UIAlertAction) in
            
        })
        alert.addAction(okButton)
        self.navigationController?.present(alert, animated: true, completion: nil)
    }
    
}

        
        
        
        
        
        

