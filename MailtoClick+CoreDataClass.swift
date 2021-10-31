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
    func getEmail() -> String {
        let url = URL(string: self.url)
        
        let subject = url?.email ?? ""
        
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
    
    func getBody() -> String {
        let url = URL(string: self.url)
        
        let body = url?.valueOf("body") ?? ""
        
        return body
    }
    
    func getURL() -> String {
        return self.url
    }
}
