//
//  MentionTableViewController.swift
//  SmashTag
//
//  Created by Jianqun Chen on 3/21/17.
//  Copyright © 2017 Jianqun Chen. All rights reserved.
//

import UIKit
import Twitter

class MentionTableViewController: UITableViewController {

    private enum MentionContent {
        case Image(Twitter.MediaItem)
        case Text(String)
    }
    
    private let titles = ["Images", "HashTags", "UserMentions", "Urls"]
    
    private var mentions = [[MentionContent]]([[], [], [], []])
    
    public var tweet: Twitter.Tweet? {
        didSet {
            if let media = tweet?.media {
                for image in media {
                    mentions[0].append(MentionContent.Image(image))
                }
            }
            if let tags = tweet?.hashtags {
                for tag in tags {
                    mentions[1].append(MentionContent.Text(tag.keyword))
                }
            }
            if let userMentions = tweet?.userMentions {
                for userMention in userMentions {
                    mentions[2].append(MentionContent.Text(userMention.keyword))
                }
            }
            if let urls = tweet?.urls {
                for url in urls {
                    mentions[3].append(MentionContent.Text(url.keyword))
                }
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Mentions"

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return mentions.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return mentions[section].count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return mentions[section].count > 0 ? titles[section] : ""
    }
    
    private struct Storyboard {
        static let MentionImageCellIdentifier = "MentionImageCell"
        static let MentionTextCellIdentifier = "MentionTextCell"
        static let SearchMentionSegueIdentifier = "SearchMentionSegue"
        static let ViewImageSegueIdentifier = "ViewImageSegue"
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let content = mentions[indexPath.section][indexPath.row]
        switch content {
        case .Image(let media):
            let cell = tableView.dequeueReusableCell(withIdentifier: Storyboard.MentionImageCellIdentifier, for: indexPath)
            if let imageData = NSData(contentsOf: media.url) { // blocks main thread!
                cell.imageView?.image = UIImage(data: imageData as Data)
            }
            return cell
        case .Text(let text):
            let cell = tableView.dequeueReusableCell(withIdentifier: Storyboard.MentionTextCellIdentifier, for: indexPath)
            cell.textLabel?.text = text
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let content = mentions[indexPath.section][indexPath.row]
        switch content {
        case .Image(let media):
            return view.frame.size.width / CGFloat(media.aspectRatio)
        case .Text:
            return UITableViewAutomaticDimension
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let content = mentions[indexPath.section][indexPath.row]
        switch content {
        case .Image:
            performSegue(withIdentifier: Storyboard.ViewImageSegueIdentifier, sender: indexPath)
        case .Text(let txt):
            if txt.hasPrefix("@") || txt.hasPrefix("#") {
                performSegue(withIdentifier: Storyboard.SearchMentionSegueIdentifier, sender: indexPath)
            } else if txt.hasPrefix("http") {
                UIApplication.shared.open(URL(string: txt)!, options: [:], completionHandler: nil)
            }
        }
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if let index = sender as? IndexPath {
            let content = mentions[index.section][index.row]
            switch content {
            case .Image:
                return true
            case .Text(let txt):
                if txt.hasPrefix("@") || txt.hasPrefix("#") {
                    return true
                } else if txt.hasPrefix("http") {
                    return false
                }
            }
        }
        return false
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let index = sender as? IndexPath {
            let content = mentions[index.section][index.row]
            switch content {
            case .Image(let media):
                if let dvc = segue.destination as? ImageViewController {
                    dvc.imageURL = media.url
                }
            case .Text(let txt):
                if let dvc = segue.destination as? TwitterTableViewController, (txt.hasPrefix("@") || txt.hasPrefix("#")) {
                    dvc.searchText = txt
                }
            }
        }
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
