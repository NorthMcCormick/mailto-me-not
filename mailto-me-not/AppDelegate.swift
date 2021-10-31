//
//  AppDelegate.swift
//  mailto-me-not
//
//  Created by North McCormick on 12/2/20.
//

import Cocoa
import SwiftUI
import CoreData
import AppKit

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    // var window: NSWindow!
    var popover: NSPopover!
    var popover_copied: NSPopover!
    var statusBarItem: NSStatusItem!
    
    @Environment(\.managedObjectContext) var managedObjectContext
    
    lazy var persistentContainer: NSPersistentContainer = {
      // 2
      let container = NSPersistentContainer(name: "MailtoMeNot")
      // 3
      container.loadPersistentStores { _, error in
        // 4
        if let error = error as NSError? {
          // You should add your own error handling code here.
          fatalError("Unresolved error \(error), \(error.userInfo)")
        }
      }
        
      return container
    }()
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Create the SwiftUI view that provides the window contents.
        let contentView = ContentView()
        
        let context = persistentContainer.viewContext
        let contentViewB = MailtoClickList().environment(\.managedObjectContext, context)
        
        let aem = NSAppleEventManager.shared();
            aem.setEventHandler(self, andSelector: #selector(AppDelegate.handleGetURLEvent(event:replyEvent:)), forEventClass: AEEventClass(kInternetEventClass), andEventID: AEEventID(kAEGetURL))

        // Create the pop over
        let popover = NSPopover()
            popover.contentSize = NSSize(width: 400, height: 400)
            popover.behavior = .transient
            popover.contentViewController = NSHostingController(rootView: contentViewB)
        
        self.popover = popover

        // Create 'copied' popover
        let popover_copied = NSPopover()
            popover_copied.contentSize = NSSize(width: 150, height: 30)
            popover_copied.behavior = .transient
            popover_copied.contentViewController = NSHostingController(rootView: contentView)
        
        self.popover_copied = popover_copied
        
        // Create status bar item
        self.statusBarItem = NSStatusBar.system.statusItem(withLength: CGFloat(NSStatusItem.variableLength))
        
        if let button = self.statusBarItem.button {
            button.image = NSImage(named: "Icon")
            button.action = #selector(statusBarButtonClicked(sender:))
            button.sendAction(on: [.leftMouseUp, .rightMouseUp])
        }
        
        // self.statusBarItem.menu = statusBarMenu;
    }
    
    @objc func statusBarButtonClicked(sender: NSStatusBarButton) {
        let event = NSApp.currentEvent!
        
        if event.type == NSEvent.EventType.rightMouseUp {
            let statusBarMenu = NSMenu(title: "MailMeNot")
            
            statusBarMenu.addItem(
                withTitle: "Quit",
                action: #selector(quitApplication(sender:)),
                keyEquivalent: "")
                
            self.statusBarItem?.menu = statusBarMenu
            self.statusBarItem?.button?.performClick(nil)

            self.statusBarItem?.menu = nil
        } else {
          print("Left Click")
          togglePopover(sender)
        }
    }
    
    @objc func quitApplication(sender: NSStatusBarButton) {
        for runningApplication in NSWorkspace.shared.runningApplications {
            let appBundleIdentifier = runningApplication.bundleIdentifier
            
            if appBundleIdentifier == "com.northmccormick.mailto-me-not" {
                runningApplication.terminate()
            }
        }
    }
    
    func addMailtoClick(url: String) {
        let newClick = MailtoClick(context: persistentContainer.viewContext)
        
        newClick.url = url
        
        saveContext()
    }
    
    @objc func handleGetURLEvent(event: NSAppleEventDescriptor, replyEvent: NSAppleEventDescriptor) {

        let urlString = event.paramDescriptor(forKeyword: AEKeyword(keyDirectObject))?.stringValue!
        let url = URL(string: urlString!)!

        addMailtoClick(url: urlString!)
        
        self.popover_copied.show(relativeTo: self.statusBarItem.button!.bounds, of: self.statusBarItem.button!, preferredEdge: NSRectEdge.minY)
        
        
        
        /*public extension NSSound {
            static let basso     = NSSound(named: .basso)
            static let blow      = NSSound(named: .blow)
            static let bottle    = NSSound(named: .bottle)
            static let frog      = NSSound(named: .frog)
            static let funk      = NSSound(named: .funk)
            static let glass     = NSSound(named: .glass)
            static let hero      = NSSound(named: .hero)
            static let morse     = NSSound(named: .morse)
            static let ping      = NSSound(named: .ping)
            static let pop       = NSSound(named: .pop)
            static let purr      = NSSound(named: .purr)
            static let sosumi    = NSSound(named: .sosumi)
            static let submarine = NSSound(named: .submarine)
            static let tink      = NSSound(named: .tink)
        }



        public extension NSSound.Name {
            static let basso     = NSSound.Name("Basso")
            static let blow      = NSSound.Name("Blow")
            static let bottle    = NSSound.Name("Bottle")
            static let frog      = NSSound.Name("Frog")
            static let funk      = NSSound.Name("Funk")
            static let glass     = NSSound.Name("Glass")
            static let hero      = NSSound.Name("Hero")
            static let morse     = NSSound.Name("Morse")
            static let ping      = NSSound.Name("Ping")
            static let pop       = NSSound.Name("Pop")
            static let purr      = NSSound.Name("Purr")
            static let sosumi    = NSSound.Name("Sosumi")
            static let submarine = NSSound.Name("Submarine")
            static let tink      = NSSound.Name("Tink")
        }*/

        
        NSSound(named: "Glass")?.play()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
            self.popover_copied.performClose(self)
        }
    }
    
    @objc func togglePopover(_ sender: AnyObject?) {
         if let button = self.statusBarItem.button {
              if self.popover.isShown {
                   self.popover.performClose(sender)
              } else {
                   self.popover.show(relativeTo: button.bounds, of: button, preferredEdge: NSRectEdge.minY)
                
                   self.popover.contentViewController?.view.window?.becomeKey()
              }
         }
    }

    func saveContext() {
      let context = persistentContainer.viewContext
        
      if context.hasChanges {
        do {
          try context.save()
        } catch {
          let nserror = error as NSError
            
          fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
      }
    }
    
    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
}

extension URL {
    func valueOf(_ queryParamaterName: String) -> String? {
        guard let url = URLComponents(string: self.absoluteString) else { return nil }
        return url.queryItems?.first(where: { $0.name == queryParamaterName })?.value
    }
    
    var email: String? {
        return scheme == "mailto" ? URLComponents(url: self, resolvingAgainstBaseURL: false)?.path : nil
    }
}

extension Color {
    public init(decimalRed red: Double, green: Double, blue: Double) {
        self.init(red: red / 255, green: green / 255, blue: blue / 255)
    }
    
    public static var flatDarkBackground: Color {
        return Color(decimalRed: 36, green: 36, blue: 36)
    }
    
    public static var flatDarkCardBackground: Color {
        return Color(decimalRed: 46, green: 46, blue: 46)
    }
}

struct AppDelegate_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
