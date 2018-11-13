//
//  Graphics.swift
//  SwiftSketch
//
//  Created by C.W. Betts on 11/12/18.
//

import Cocoa


class Graphic: NSObject, NSCopying {
	func copy(with zone: NSZone? = nil) -> Any {
		let newObj = type(of: self).init()
		newObj.bounds = bounds
		newObj.fillColor = fillColor
		newObj.drawsFill = drawsFill
		newObj.strokeColor = strokeColor
		newObj.drawsStroke = drawsStroke
		newObj.strokeLineWidth = strokeLineWidth
		
		return newObj
	}
	
	static var didChangeNotification: NSNotification.Name {
		return NSNotification.Name("SKTGraphicDidChange")
	}
	
	private var _origBounds: NSRect = .zero

	enum Knob: Int32 {
		case none = 0
		case upperLeft
		case upperMiddle
		case upperRight
		case middleLeft
		case middleRight
		case lowerLeft
		case lowerMiddle
		case lowerRight
	}
	
	struct KnobMask : OptionSet {
		let rawValue: UInt32
		
		init(rawValue: UInt32) {
			self.rawValue = rawValue
		}
		
		static var upperLeft: KnobMask {
			return KnobMask(rawValue: UInt32(1 << Knob.upperLeft.rawValue))
		}
		
		static var upperMiddle: KnobMask {
			return KnobMask(rawValue: UInt32(1 << Knob.upperMiddle.rawValue))
		}
		
		static var upperRight: KnobMask {
			return KnobMask(rawValue: UInt32(1 << Knob.upperRight.rawValue))
		}
		
		static var middleLeft: KnobMask {
			return KnobMask(rawValue: UInt32(1 << Knob.middleLeft.rawValue))
		}
		
		static var middleRight: KnobMask {
			return KnobMask(rawValue: UInt32(1 << Knob.middleRight.rawValue))
		}
		
		static var lowerLeft: KnobMask {
			return KnobMask(rawValue: UInt32(1 << Knob.lowerLeft.rawValue))
		}
		
		static var lowerMiddle: KnobMask {
			return KnobMask(rawValue: UInt32(1 << Knob.lowerMiddle.rawValue))
		}
		
		static var lowerRight: KnobMask {
			return KnobMask(rawValue: UInt32(1 << Knob.lowerRight.rawValue))
		}
		
		static var all: KnobMask {
			return KnobMask(rawValue: 0xffffffff)
		}
	}

	
	weak var document: Document?
	
	var undoManager: UndoManager? {
		return document?.undoManager
	}
	
	override required init() {
		
		super.init()
	}
	
	// =================================== Primitives ===================================
	/// This sends the did change notification.  All change primitives should call it.
	func didChange() {
		
	}
	
	
	@objc var bounds: NSRect = NSMakeRect(0.0, 0.0, 1.0, 1.0)
	
	@objc var drawsFill: Bool = false {
		willSet {
			if drawsFill != newValue {
				let currVal = drawsFill
				undoManager?.registerUndo(withTarget: self, handler: { (target) in
					target.drawsFill = currVal
				})
			}
		}
		didSet {
			if drawsFill != oldValue {
				didChange()
			}
		}
	}
	
	@objc var fillColor: NSColor! = NSColor.white
	
	@objc var drawsStroke: Bool = true {
		willSet {
			if drawsStroke != newValue {
				let currVal = drawsStroke
				undoManager?.registerUndo(withTarget: self, handler: { (target) in
					target.drawsStroke = currVal
				})
			}
		}
		didSet {
			if drawsStroke != oldValue {
				didChange()
			}
		}
	}
	
	@objc var strokeColor: NSColor! = NSColor.black
	
	@objc var strokeLineWidth: CGFloat = 1
	
	
	// =================================== Extended mutation ===================================
	func startBoundsManipulation() {
		
	}
	
	func stopBoundsManipulation() {
		
	}
	
	func move(by vector: NSPoint) {
		bounds = bounds.offsetBy(dx: vector.x, dy: vector.y)
	}
	
	func flipHorizontally() {
		
	}
	
	func flipVertically() {
		
	}
	
	func resize(byMoving knob2: Knob, to point: NSPoint) -> Knob {
		var knob = knob2
		
		return knob
	}
	
	func makeNaturalSize() {
		
	}
	
	
	// =================================== Subclass capabilities ===================================
	var canDrawStroke: Bool {
		return true
	}
	
	var canDrawFill: Bool {
		return true
	}
	
	var hasNaturalSize: Bool {
		return true
	}
	
	
	// =================================== Persistence ===================================
	func propertyListRepresentation() -> NSMutableDictionary! {
		return nil
	}
	
	class func graphic(withPropertyListRepresentation dict: [AnyHashable : Any]!) -> Any! {
		return nil
	}
	
	func loadPropertyListRepresentation(_ dict: [AnyHashable : Any]!) {
		
	}

	// MARK: Drawing
}

class Circle: Graphic {
	var bezierPath: NSBezierPath {
		let path = NSBezierPath(ovalIn: self.bounds)
		path.lineWidth = strokeLineWidth
		return path
	}
	
	override func makeNaturalSize() {
		var bounds = self.bounds
		if (bounds.size.width < bounds.size.height) {
			bounds.size.height = bounds.size.width;
			self.bounds = bounds
		} else if (bounds.size.width > bounds.size.height) {
			bounds.size.width = bounds.size.height;
			self.bounds = bounds
		}
	}
}
