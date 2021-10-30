//
//  MailtoClick+CoreDataProperties.swift
//  mailto-me-not
//
//  Created by North McCormick on 10/30/21.
//
//

import Foundation
import CoreData


extension MailtoClick {

    @nonobjc public class func createFetchRequest() -> NSFetchRequest<MailtoClick> {
        return NSFetchRequest<MailtoClick>(entityName: "MailtoClick")
    }

    @NSManaged public var url: String

}

extension MailtoClick : Identifiable {

}
