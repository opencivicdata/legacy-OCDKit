//
//  DetailViewController.swift
//  OCDKitExample
//
//  Created by Daniel Cloud on 11/13/14.
//  Copyright (c) 2014 Sunlight Foundation. All rights reserved.
//

import UIKit
import OCDKit

class DetailViewController: UITableViewController {

    @IBOutlet weak var detailDescriptionLabel: UILabel!
    var objects: Array<JSON> = []
    var opencivicdata:OpenCivicData = OpenCivicData()


    var detailType: OCDType? {
        didSet {
            // Update the view.
            self.configureView()
        }
    }

    func configureView() {
        // Update the user interface for the detail item.
        if let type = self.detailType {
            let title = type.label()
            self.title = "\(title.capitalizedString) objects"
        }
    }

    func loadData() {
        if let type = self.detailType? {

            typealias ApiMethod = () -> Request
            var method: ApiMethod?

            switch type {
            case .Bill:
                method = self.opencivicdata.bills
            case .Division:
                method = self.opencivicdata.divisions
            case .Event:
                method = self.opencivicdata.events
            case .Jurisdiction:
                method = self.opencivicdata.jurisdictions
            case .Person:
                method = self.opencivicdata.people
            case .Vote:
                method = self.opencivicdata.votes
            }

            if let method = method {
                method().responseSwiftyJSON { (_, _, JSON, error) in
                    let count = JSON["meta"]["count"].intValue
                    println("Got \(count) objects")
                    self.objects = JSON["results"].arrayValue
                    let errorMessage:String? = JSON["error"].string
                    self.tableView.reloadData()
                    if let message = errorMessage {
                        let alertcontroller = UIAlertController(title: "Error", message: message, preferredStyle: UIAlertControllerStyle.ActionSheet)
                        alertcontroller.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.Default, handler: nil))
                        self.presentViewController(alertcontroller, animated: true, completion: nil)
                    }
                    else if self.objects.count == 0 {
                        let alertcontroller = UIAlertController(title: "No results", message: "There were no results", preferredStyle: UIAlertControllerStyle.ActionSheet)
                        alertcontroller.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.Default, handler: nil))
                        self.presentViewController(alertcontroller, animated: true, completion: nil)
                    }
                }
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let config = Configuration()
        if let key = config.properties["OCD_API_KEY"] as? String {
            self.opencivicdata.apiKey = key
        }
        self.configureView()
        self.loadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table View

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.objects.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell

        let data = self.objects[indexPath.row]

        let text: String = data["title"].string ?? data["name"].string ?? data["motion_text"].string ?? "Something"
        cell.textLabel.text = text

        let id: String = data["id"].string ?? "No id"
        cell.detailTextLabel?.text = id

        return cell
    }

}

