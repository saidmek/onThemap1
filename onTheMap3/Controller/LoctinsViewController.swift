//
//  LoctinsViewController.swift
//  onTheMap3
//
//  Created by sid almekhlfi on 30/05/2020.
//  Copyright © 2020 saeed almekhlfi. All rights reserved.
//

import UIKit

class LoctinsViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var selectedIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate =  self
        _ = onThemapClient.getStudents(completion: { (data, error) in
            LocationModel.studentList = data
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        })
        
        // Do any additional setup after loading the view.
    }
    
    
    
    @IBAction func Logout(_ sender: Any) {
        
        
        onThemapClient.logOut {
            DispatchQueue.main.async {
                
                self.dismiss(animated: true, completion: nil)
            }
            
        }
        
        
        
    }
    
    
    
    
    @IBAction func refreshTapped(_ sender: Any) {
        _ = onThemapClient.getStudents(completion: { (data, error) in
            LocationModel.studentList = data
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        })
    }
    
}

extension LoctinsViewController :UITableViewDataSource , UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currentcell = tableView.cellForRow(at: indexPath)
        
        
        if let toOpen = currentcell?.detailTextLabel?.text! {
            UIApplication.shared.open(URL(string: toOpen)!, options: [:], completionHandler: nil)
            
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return LocationModel.studentList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for:indexPath)
        let data =  LocationModel.studentList[indexPath.row]
        cell.textLabel?.text = data.firstName
        cell.detailTextLabel?.text = data.mediaURL
        cell.imageView?.image = UIImage(named: "icon_pin")
        
        return cell
    }
}

