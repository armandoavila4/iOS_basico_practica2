//
//  Task+CoreDataProperties.swift
//  CoreDataList
//
//  Created by Jorge Armando Avila Estrada on 17/12/22.
//
//

import Foundation
import CoreData


extension Task {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Task> {
        return NSFetchRequest<Task>(entityName: "Task")
    }

    @NSManaged public var notes: String?
    @NSManaged public var date: Date
    @NSManaged public var title: String

}

extension Task : Identifiable {

}
