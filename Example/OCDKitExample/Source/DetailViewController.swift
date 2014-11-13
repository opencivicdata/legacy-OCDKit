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
    var api:OpenCivicData?


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
                method = self.api?.bills
            case .Division:
                method = self.api?.divisions
            case .Event:
                method = self.api?.events
            case .Jurisdiction:
                method = self.api?.jurisdictions
            case .Person:
                method = self.api?.people
            case .Vote:
                method = self.api?.votes
            }

            if let method = method {
                method().responseSwiftyJSON { (_, _, JSON, error) in
                    let count = JSON["meta"]["count"].intValue
                    println("Got \(count) objects")
                    self.objects = JSON["results"].arrayValue
                    self.tableView.reloadData()
                }
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.api = OpenCivicData(apiKey: "")
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

