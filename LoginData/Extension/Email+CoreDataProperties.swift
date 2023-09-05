//
//  Email+CoreDataProperties.swift
//  
//
//  Created by apple on 02/09/23.
//
//

import Foundation
import CoreData


extension Email {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Email> {
        return NSFetchRequest<Email>(entityName: "Email")
    }

    @NSManaged public var email: String?
    @NSManaged public var password: String?

}
