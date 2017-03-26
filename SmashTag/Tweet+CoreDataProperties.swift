//
//  Tweet+CoreDataProperties.swift
//  SmashTag
//
//  Created by Jianqun Chen on 3/25/17.
//  Copyright © 2017 Jianqun Chen. All rights reserved.
//

import Foundation
import CoreData


extension Tweet {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Tweet> {
        return NSFetchRequest<Tweet>(entityName: "Tweet");
    }

    @NSManaged public var unique: String?
    @NSManaged public var queryText: String?
    @NSManaged public var mentions: NSSet?
    @NSManaged public var query: Query?

}

// MARK: Generated accessors for mentions
extension Tweet {

    @objc(addMentionsObject:)
    @NSManaged public func addToMentions(_ value: Mention)

    @objc(removeMentionsObject:)
    @NSManaged public func removeFromMentions(_ value: Mention)

    @objc(addMentions:)
    @NSManaged public func addToMentions(_ values: NSSet)

    @objc(removeMentions:)
    @NSManaged public func removeFromMentions(_ values: NSSet)

}
