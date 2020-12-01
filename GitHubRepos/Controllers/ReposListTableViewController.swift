//
//  ReposListTableViewController.swift
//  GitHubRepos
//
//  Created by Vijay Guruju on 28/11/20.
//  Copyright © 2020 V2Apps. All rights reserved.
//

import UIKit

class ReposListTableViewController: UITableViewController {

    var repositories = [Repository]()

       override func viewDidLoad() {
           super.viewDidLoad()

           // Uncomment the following line to preserve selection between presentations
           // self.clearsSelectionOnViewWillAppear = false

           // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
           // self.navigationItem.rightBarButtonItem = self.editButtonItem
       }

       // MARK: - Table view data source

       override func numberOfSections(in tableView: UITableView) -> Int {
           return 1
       }

       override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           return self.repositories.count
       }

       
       override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell = tableView.dequeueReusableCell(withIdentifier: "RepoCell", for: indexPath) as! RepoTableViewCell

           cell.textLabel?.text = self.repositories[indexPath.row].name

           return cell
       }
       
       //MARK:- TableView Delegate method
       override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
           
           let detailsVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailsViewController") as! DetailsViewController
           let selectedRepo =  self.repositories[indexPath.row]
           detailsVC.name = selectedRepo.name
           detailsVC.desc =  selectedRepo.description ?? ""
           detailsVC.contributorsUrl = selectedRepo.contributors_url
           detailsVC.issuesUrl = selectedRepo.issues_url
           self.navigationController?.show(detailsVC, sender: self)

       }

   }

