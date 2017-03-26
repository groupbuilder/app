//
//  StatsTableViewController.swift
//  SmashTag
//
//  Created by Jianqun Chen on 3/23/17.
//  Copyright © 2017 Jianqun Chen. All rights reserved.
//

import UIKit
import CoreData

class StatsTableViewController: CoreDataTableViewController {
    var query: String? { didSet { updateUI() } }
    var managedContext: NSManagedObjectContext? { didSet {updateUI()} }
    
    private func updateUI() {
        if let context = managedContext, (query?.characters.count)! > 0 {
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Mention")
            request.predicate = NSPredicate(format: "query = %@ AND count > 1", query!)
            
            let sortCountKey = NSSortDescriptor(key: "count", ascending: false)
            let sortNameKey = NSSortDescriptor(key: "text", ascending: true, selector: #selector(NSString.localizedStandardCompare(_:)))
            
            request.sortDescriptors = [sortCountKey, sortNameKey]
            fetchedResultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
            
        } else {
            fetchedResultsController = nil
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StatsCell", for: indexPath)
        if let mention = fetchedResultsController?.object(at: indexPath) as? Mention {
            var text: String?
            var count: Int32?
            mention.managedObjectContext?.performAndWait {
                text = mention.text
                count = mention.count
            }
            cell.textLabel?.text = text
            cell.detailTextLabel?.text = "tweets.count: " + String(count!)
        }
        return cell
    }
}
