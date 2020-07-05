//
//  StudentListController.swift
//  onTheMap3
//
//  Created by sid almekhlfi on 30/05/2020.
//  Copyright © 2020 saeed almekhlfi. All rights reserved.
//

import UIKit

class StudentListController: UITableViewController   {
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        _ = onThemapClient.getStudents(completion: { (locations, error) in
            LocationModel.studentList = locations
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        })
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        // #warning Incomplete implementation, return the number of rows
        return 0
        
    }
    
  
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
    }
    
  
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */


}

