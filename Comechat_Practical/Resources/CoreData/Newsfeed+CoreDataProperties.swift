//
//  Newsfeed+CoreDataProperties.swift
//  Comechat_Practical
//
//  Created by Disha Shah on 02/12/21.
//

import Foundation
import CoreData

extension Newsfeed {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Newsfeed> {
        return NSFetchRequest<Newsfeed>(entityName: "Newsfeed")
    }
    @NSManaged public var articles: Data?
}
