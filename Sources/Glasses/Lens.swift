import Foundation

public protocol Getter {
	associatedtype Whole
	associatedtype Part
	
	func `get`(_ whole: Whole) -> Part
}

public protocol Setter {
	associatedtype Whole
	associatedtype Part
	
	func update(_ whole: inout Whole, _ f: @escaping (inout Part) -> Void) -> Void
}

public protocol LensOptic<Whole, Part>: Getter, Setter {}

extension LensOptic {
	public func `set`(_ whole: inout Whole, to newValue: Part) {
		update(&whole) { part in
			part = newValue
		}
	}
	
	public func setting(_ whole: Whole, to newValue: Part) -> Whole {
		var copy = whole
		self.set(&copy, to: newValue)
		return copy
	}
	
	public func updating(
		_ whole: Whole,
		_ f: @escaping (inout Part) -> Void
	) -> Whole {
		var copy = whole
		self.update(&copy, f)
		return copy
	}
}

extension KeyPath: Getter {
	public func get(_ whole: Root) -> Value {
		whole[keyPath: self]
	}
}

extension WritableKeyPath: LensOptic {
	public func update(
		_ whole: inout Root,
		_ f: @escaping (inout Value) -> Void
	) {
		var value = whole[keyPath: self]
		f(&value)
		whole[keyPath: self] = value
	}
}

//
//public struct DefaultLens<Whole, Part>: LensOptic {
//	var _get: (Whole) -> Part
//	var _update: (Whole, inout Part) -> Void
//	
//	init(
//		get: @escaping (Whole) -> Part,
//		update: @escaping (Whole, inout Part) -> Void
//	) {
//		self._get = get
//		self._update = update
//	}
//	
//	public func get(_ whole: Whole) -> Part {
//		self._get(whole)
//	}
//	
//	public func update(_ whole: inout Whole, _ f: @escaping (inout Part) -> Void) {
//		self._update(&whole, f)
//	}
//}
