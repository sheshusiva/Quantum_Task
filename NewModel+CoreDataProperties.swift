//
//  NewModel+CoreDataProperties.swift
//  LoginData
//
//  Created by apple on 04/09/23.
//
//

import Foundation
import CoreData


extension NewModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<NewModel> {
        return NSFetchRequest<NewModel>(entityName: "NewModel")
    }

    @NSManaged public var author: String?
    @NSManaged public var content: String?
    @NSManaged public var descrip: String?
    @NSManaged public var publishedAt: String?
    @NSManaged public var title: String?
    @NSManaged public var urlToImage: String?

}

extension NewModel : Identifiable {

}
