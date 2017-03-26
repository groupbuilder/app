//
//  Tweet+CoreDataClass.swift
//  SmashTag
//
//  Created by Jianqun Chen on 3/25/17.
//  Copyright © 2017 Jianqun Chen. All rights reserved.
//

import Foundation
import CoreData
import Twitter

public class Tweet: NSManagedObject {
    class func tweetWithInfo(_ keyword: String, _ tweetInfo: Twitter.Tweet, _ context: NSManagedObjectContext) -> Tweet? {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Tweet")
        request.predicate = NSPredicate(format: "unique = %@ AND query = %@", tweetInfo.id, keyword)
        
        if let tweet = (try? context.fetch(request))?.first as? Tweet {
            return tweet
        } else if let tweet = NSEntityDescription.insertNewObject(forEntityName: "Tweet", into: context) as? Tweet {
            tweet.queryText = keyword
            tweet.unique = tweetInfo.id
            for mentionText in tweetInfo.hashtags + tweetInfo.userMentions {
                _ = Mention.mentionWithInfo(keyword, mention: mentionText.keyword, context)
            }
            return tweet
        }
        return nil
    }
}
