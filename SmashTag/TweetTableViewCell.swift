//
//  TweetTableViewCell.swift
//  Smashtag
//
//  Created by CS193p Instructor.
//  Copyright © 2016 Stanford University. All rights reserved.
//
import UIKit
import Twitter

class TweetTableViewCell: UITableViewCell {
    @IBOutlet weak var tweetScreenNameLabel: UILabel!
    @IBOutlet weak var tweetTextLabel: UILabel!
    @IBOutlet weak var tweetCreatedLabel: UILabel!
    @IBOutlet weak var tweetProfileImageView: UIImageView!
    
    var tweet: Twitter.Tweet? {
        didSet {
            updateUI()
        }
    }
    
    private func updateUI() {
        // reset any existing tweet information
        tweetTextLabel?.attributedText = nil
        tweetScreenNameLabel?.text = nil
        tweetProfileImageView?.image = nil
        tweetCreatedLabel?.text = nil
        
        // load new information from our tweet (if any)
        if let tweet = self.tweet {
            // tweetTextLabel?.text = tweet.text
            let attributeString = NSMutableAttributedString(string: tweet.text)
            for hashtag in tweet.hashtags {
                attributeString.addAttributes([NSForegroundColorAttributeName : UIColor.brown], range: hashtag.nsrange)
            }
            for user in tweet.userMentions {
                attributeString.addAttributes([NSForegroundColorAttributeName : UIColor.green], range: user.nsrange)
            }
            for url in tweet.urls {
                attributeString.addAttributes([NSForegroundColorAttributeName : UIColor.blue], range: url.nsrange)
            }
            tweetTextLabel?.attributedText = attributeString
            if tweetTextLabel?.text != nil  {
                for _ in tweet.media {
                    tweetTextLabel.text! += " 📷"
                }
            }
            
            tweetScreenNameLabel?.text = "\(tweet.user)" // tweet.user.description
            
            if let profileImageURL = tweet.user.profileImageURL {
                if let imageData = NSData(contentsOf: profileImageURL) { // blocks main thread!
                    tweetProfileImageView?.image = UIImage(data: imageData as Data)
                }
            }
            
            let formatter = DateFormatter()
            if NSDate().timeIntervalSince(tweet.created) > 24*60*60 {
                formatter.dateStyle = DateFormatter.Style.short
            } else {
                formatter.timeStyle = DateFormatter.Style.short
            }
            tweetCreatedLabel?.text = formatter.string(from: tweet.created)
        }
        
    }
}
