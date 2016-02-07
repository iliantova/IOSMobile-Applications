//
//  TableViewController.swift
//  Game
//
//  Created by Iliyana Antova on 2/7/16.
//  Copyright © 2016 Iliyana Antova. All rights reserved.
//

import UIKit
import CoreData

class TableViewController: UITableViewController {
    
    var skor = [NSManagedObject]()
    var curentUserScor = [NSManagedObject]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        let fetchRequest = NSFetchRequest(entityName: "ScorPoint")
        
        do {
            let results = try self.managedContext.executeFetchRequest(fetchRequest)
            self.skor = results as! [NSManagedObject]
            self.tableView.reloadData()
        }
        catch let err as NSError {
            print("Error: \(err)")
        }
        for var i = 0; i < self.skor.count; i++
        {
            let city = self.skor[i];
            let nikName = (UIApplication.sharedApplication().delegate as! AppDelegate).nikNameData;
            let name = city.valueForKey("userPoints") as! NSManagedObject;
            let user = name.valueForKey("nikName") as! String;
            if (user == nikName) {
                curentUserScor.append(city);
            }

        }
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows

        return curentUserScor.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TheCell")
        
        let curenRowPoints = curentUserScor[indexPath.row];
        let data = curenRowPoints.valueForKey("data") as! String;
        let pointValue = curenRowPoints.valueForKey("points") as! String;
      cell?.textLabel!.text = "Points: \(pointValue)              \(data)"
        
        return cell!;
    }
    
    lazy var managedContext: NSManagedObjectContext = {
        let managedContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
        return managedContext;
    }()

}
