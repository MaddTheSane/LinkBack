//
//  AppDelegate.swift
//  SwiftSketch
//
//  Created by C.W. Betts on 11/12/18.
//

import Cocoa
import LinkBack

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate, LinkBackServerDelegate {



	func applicationDidFinishLaunching(_ aNotification: Notification) {
		//[LinkBack publishServerWithName: @"sketch" delegate: self]
		LinkBack.publishServer(withName: "sketch", delegate: self)
	}

	func applicationWillTerminate(_ aNotification: Notification) {
		// Insert code here to tear down your application
	}

	func linkBackDidClose(_ link: LinkBack) {
		NSLog("linkBackDidClose: %@", link)
		// find document for live link.  Close document.
		let doc = link.representedObject as? Document
		doc?.close()

	}
	
	func linkBackClientDidRequestEdit(_ link: LinkBack) {
		NSLog("linkBackClientDidRequestEdit: %@", link)
		var doc: Document
		if let repObj = link.representedObject {
			guard let repDoc = repObj as? Document else {
				NSSound.beep()
				return
			}
			doc = repDoc
		} else {
			// if no document already exists for this link, create one and get the data.
			doc = Document(linkBack: link)
			NSDocumentController.shared.addDocument(doc)
			doc.makeWindowControllers() // causes it to display.
		}

		// always bring app and document window to the front.
		NSApp.activate(ignoringOtherApps: true)
		doc.showWindows()
	}
}

