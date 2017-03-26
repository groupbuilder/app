//
//  Mention+CoreDataProperties.swift
//  SmashTag
//
//  Created by Jianqun Chen on 3/25/17.
//  Copyright © 2017 Jianqun Chen. All rights reserved.
//

import Foundation
import CoreData


extension Mention {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Mention> {
        return NSFetchRequest<Mention>(entityName: "Mention");
    }

    @NSManaged public var count: Int32
    @NSManaged public var text: String?
    @NSManaged public var query: String?
    @NSManaged public var tweets: NSSet?

}

// MARK: Generated accessors for tweets
extension Mention {

    @objc(addTweetsObject:)
    @NSManaged public func addToTweets(_ value: Tweet)

    @objc(removeTweetsObject:)
    @NSManaged public func removeFromTweets(_ value: Tweet)

    @objc(addTweets:)
    @NSManaged public func addToTweets(_ values: NSSet)

    @objc(removeTweets:)
    @NSManaged public func removeFromTweets(_ values: NSSet)

}
