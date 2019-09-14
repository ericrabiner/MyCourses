//
//  CourseList.swift
//  MyCourses
//
//  Created by eric on 2019-09-14.
//  Copyright © 2019 Eric Rabiner. All rights reserved.
//

import UIKit

class CourseList: UITableViewController {
    
    // Variables
    struct Course: Codable {
        let id: Int
        let courseCode: String
        let courseName: String
    }
    
    struct PackageCourses: Codable {
        let student: String
        let timestamp: Date
        let count: Int
        let version: String
        let data: [Course]?
    }
    
    let url = URL(string: "https://raw.githubusercontent.com/ericrabiner/MyCourses/master/mycourses.json")
    
    var coursePackage: PackageCourses?
    
    var checkedRow: IndexPath?
    
    // Outlets

    
    // Lifecycle
    func doRequest(url: URL) -> PackageCourses? {
        do {
            // Attempt to get the data from the web API
            let data = try Data(contentsOf: url)
            
            // Create and configure a JSON decoder
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            
            // Attempt to decode the data into a "PackageCourses" object
            let result = try decoder.decode(PackageCourses.self, from: data)
            return result
        }
        catch {
            // Uh oh, error
            print("Request error: \(error.localizedDescription)")
            return nil
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        coursePackage = doRequest(url: url!)
        title = "\(coursePackage?.student ?? "")'s courses"
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return coursePackage?.data?.count ?? 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "default", for: indexPath)

        // Configure the cell...
        cell.textLabel?.text = coursePackage?.data?[indexPath.row].courseCode
        cell.detailTextLabel?.text = coursePackage?.data?[indexPath.row].courseName

        return cell
    }
    
    // iOS runtime calls this when user taps on row
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
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
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
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
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
