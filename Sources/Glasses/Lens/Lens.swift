import Foundation

public protocol Getter {
	associatedtype Whole
	associatedtype Part
	
	func `get`(_ whole: Whole) -> Part
}

public protocol Setter {
	associatedtype Whole
	associatedtype NewWhole
	associatedtype Part
	associatedtype NewPart
	
	func update(
		_ whole: Whole,
		_ f: @escaping (Part) -> NewPart
	) -> NewWhole
}

extension Setter {
	public func update(
		_ whole: inout Whole,
		_ f: @escaping (inout Part) -> Void
	) -> Void
	where NewWhole == Whole, NewPart == Part {
		whole = self.update(whole) { part in
			var copy = part
			f(&copy)
			return copy
		}
	}
}

public protocol LensOptic<Whole, Part, NewWhole, NewPart>: Getter, Setter {}

public typealias SimpleLensOptic<Whole, Part> = LensOptic<Whole, Part, Whole, Part>

extension LensOptic {
	public func `set`(
		_ whole: inout Whole,
		to newValue: NewPart
	) where NewWhole == Whole, NewPart == Part {
		update(&whole) { part in
			part = newValue
		}
	}
	
	public func setting(
		_ whole: Whole,
		to newValue: Part
	) -> Whole
	where NewWhole == Whole, NewPart == Part {
		var copy = whole
		self.set(&copy, to: newValue)
		return copy
	}
	
	public func updating(
		_ whole: Whole,
		_ f: @escaping (inout Part) -> Void
	) -> Whole
	where NewWhole == Whole, NewPart == Part {
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
	public typealias NewWhole = Root
	public typealias NewPart = Value
	
	public func update(
		_ whole: Root,
		_ f: @escaping (Value) -> Value
	) -> Root {
		var result = whole
		result[keyPath: self] = f(result[keyPath: self])
		return result
	}
}
