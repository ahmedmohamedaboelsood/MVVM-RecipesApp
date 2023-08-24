//
//  Recipes+CoreDataProperties.swift
//  
//
//  Created by Ahmed Abo Elsood on 23/08/2023.
//
//

import Foundation
import CoreData


extension Recipes {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Recipes> {
        return NSFetchRequest<Recipes>(entityName: "Recipes")
    }

    @NSManaged public var id: String?
    @NSManaged public var fats: String?
    @NSManaged public var time: String?
    @NSManaged public var name: String?
    @NSManaged public var image: String?
    @NSManaged public var weeks: NSObject?
    @NSManaged public var carbos: String?
    @NSManaged public var rating: Double
    @NSManaged public var fibers: String?
    @NSManaged public var country: String?
    @NSManaged public var ratings: Int64
    @NSManaged public var calories: String?
    @NSManaged public var headline: String?
    @NSManaged public var keywords: NSObject?
    @NSManaged public var products: NSObject?
    @NSManaged public var proteins: String?
    @NSManaged public var favorites: Int64
    @NSManaged public var difficulty: Int64
    @NSManaged public var recipedescription: String?
    @NSManaged public var highlighted: Bool
    @NSManaged public var ingredients: NSObject?

}
