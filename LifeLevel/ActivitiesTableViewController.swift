//
//  ActivitiesTableViewController.swift
//  LifeLevel
//
//  Created by Mac on 25/09/2017.
//  Copyright © 2017 Mac. All rights reserved.
//

import UIKit

class ActivitiesTableViewController: UITableViewController {
    
    //MARK: Properties
    var activities = [Activity]()
    var loginInfo = LoginInfo()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        self.tableView.rowHeight = 140.0
        
        let clSrvIntegBase = ActivityClSrvInteg()
        clSrvIntegBase.accessToken = loginInfo.accessToken
        clSrvIntegBase.getUserActivities(userId: loginInfo.userId, mainUserId: loginInfo.userId, fromActivityId: 100)
        {response in
            //load activities to view
            self.activities = response
            
            self.tableView.reloadData()
        }
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return activities.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "ActivityTableViewCell"
        
        //let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? ActivityTableViewCell  else {
            fatalError("The dequeued cell is not an instance of ActivityTableViewCell.")
        }

        let activity = activities[indexPath.row]
        
        if !activity.mainPhoto.isEmpty
        {
            let tempPhoto = UIImage(named: activity.mainPhoto)
            cell.activityImageView.image = tempPhoto
        }
        else
        {
            cell.activityImageView.image = UIImage(named:"Activity1")
        }
        
        cell.activityTypeLabel.text = activity.activity
        cell.dateLabel.text = activity.date
        cell.decriptionLabel.text = activity.description
        cell.likesLabel.text = String(activity.totalLikeCount) + " likes"
        cell.userLabel.text = self.loginInfo.username

        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
