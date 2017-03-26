//
//  Mention+CoreDataClass.swift
//  SmashTag
//
//  Created by Jianqun Chen on 3/25/17.
//  Copyright © 2017 Jianqun Chen. All rights reserved.
//

import Foundation
import CoreData


public class Mention: NSManagedObject {
    class func mentionWithInfo(_ keyword: String, mention text: String, _ context: NSManagedObjectContext) -> Mention? {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Mention")
        request.predicate = NSPredicate(format: "text = [cd] %@ AND query = %@", text, keyword)
        
        if let mention = (try? context.fetch(request))?.first as? Mention {
            mention.count = mention.count + 1
            return mention
        } else if let mention = NSEntityDescription.insertNewObject(forEntityName: "Mention", into: context) as? Mention {
            mention.text = text
            mention.count = 1
            mention.query = keyword
            return mention
        }
        return nil
    }
}
