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
	public func `set`(_ whole: inout Whole, newValue: Part) {
		update(&whole) { part in
			part = newValue
		}
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
