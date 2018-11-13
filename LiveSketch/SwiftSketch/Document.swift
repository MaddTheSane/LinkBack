//
//  Document.swift
//  SwiftSketch
//
//  Created by C.W. Betts on 11/12/18.
//

import Cocoa
import LinkBack

//NSString *SKTDrawDocumentType = @"Apple Sketch Graphic Format";
let SKTDrawDocumentTypeV2 = NSPasteboard.PasteboardType("Apple Sketch Graphic Format")
let SKTDrawDocumentType = NSPasteboard.PasteboardType("Apple Sketch Graphic Format 3")

class Document: NSDocument {
	private var link: LinkBack?

	override init() {
	    super.init()
		// Add your subclass-specific initialization here.
	}

	override class var autosavesInPlace: Bool {
		return true
	}

	override var windowNibName: NSNib.Name? {
		// Returns the nib file name of the document
		// If you need to use a subclass of NSWindowController or if your document supports multiple NSWindowControllers, you should remove this property and override -makeWindowControllers instead.
		return NSNib.Name("Document")
	}

	override func data(ofType typeName: String) throws -> Data {
		// Insert code here to write your document to data of the specified type, throwing an error in case of failure.
		// Alternatively, you could remove this method and override fileWrapper(ofType:), write(to:ofType:), or write(to:ofType:for:originalContentsURL:) instead.
		throw NSError(domain: NSOSStatusErrorDomain, code: unimpErr, userInfo: nil)
	}

	override func read(from data: Data, ofType typeName: String) throws {
		// Insert code here to read your document from the given data of the specified type, throwing an error in case of failure.
		// Alternatively, you could remove this method and override read(from:ofType:) instead.
		// If you do, you should also override isEntireFileLoaded to return false if the contents are lazily loaded.
		throw NSError(domain: NSOSStatusErrorDomain, code: unimpErr, userInfo: nil)
	}
	
	func closeLinkIfNeeded() {
		if let link = link {
			link.representedObject = nil
			link.closeLink()
			self.link = nil
		}
	}
	
	convenience init(linkBack aLink: LinkBack) {
		self.init()
		link = aLink
		link?.representedObject = self
		
		// get graphics from link
		let linkBackData = link?.pasteboard.propertyList(forType: .linkBack) as! NSDictionary
		var graphics = linkBackData.linkBackAppData
		//graphics = [self drawDocumentDictionaryFromData: graphics] ;
		//graphics = [self graphicsFromDrawDocumentDictionary: graphics] ;
		//[self setGraphics: graphics] ;

		// fix up undo
		undoManager?.removeAllActions()
		updateChangeCount(.changeCleared)
	}
	
	override func close() {
		closeLinkIfNeeded()
		super.close()
	}
	
	override func save(_ sender: Any?) {
		if let link = link {
			
		} else {
			super.save(sender)
		}
	}
}

