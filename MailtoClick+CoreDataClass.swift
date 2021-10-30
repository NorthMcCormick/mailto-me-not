//
//  MailtoClick+CoreDataClass.swift
//  mailto-me-not
//
//  Created by North McCormick on 10/30/21.
//
//

import Foundation
import CoreData

@objc(MailtoClick)
public class MailtoClick: NSManagedObject {
    var urlParams: URL?
    
    convenience init(context moc: NSManagedObjectContext) {
        self.init(context: moc)
        
        self.urlParams = URL(string: self.url)
    }
    
    func getEmail() -> String {
        let url = URL(string: self.url)
        
        let subject = url?.valueOf("subject") ?? ""
        
        return subject
    }
    
    func getSubject() -> String {
        let url = URL(string: self.url)
        
        let subject = url?.valueOf("subject") ?? ""
        
        return subject
    }
    
    func getCC() -> String {
        let url = URL(string: self.url)
        
        let cc = url?.valueOf("cc") ?? ""
        
        return cc
    }
    
    func getBCC() -> String {
        let url = URL(string: self.url)
        
        let bcc = url?.valueOf("bcc") ?? ""
        
        return bcc
    }
    
    func getURL() -> String {
        return self.url
    }
}
