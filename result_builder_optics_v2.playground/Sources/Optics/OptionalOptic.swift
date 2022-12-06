import Foundation

public protocol OptionalOptic<Whole, Part> {
	associatedtype Whole
	associatedtype Part
		
	func tryGet(_ whole: Whole) -> Part?
	
	func tryUpdate(_ whole: inout Whole, _ f: @escaping (inout Part) -> Void) -> Void
}

extension OptionalOptic {
	public func `set`(_ whole: inout Whole, newValue: Part) {
		tryUpdate(&whole) { part in
			part = newValue
		}
	}
}

extension CasePath: OptionalOptic {
	public typealias Whole = Root
	public typealias Part = Value
	
	public func tryGet(_ whole: Whole) -> Part? {
		self.extract(from: whole)
	}
	
	public func tryUpdate(_ whole: inout Whole, _ f: @escaping (inout Part) -> Void) {
//		try? self.modify(&whole, f)
		guard var value = self.extract(from: whole) else {
			return
		}

		f(&value)

		whole = self.embed(value)
	}
}

public struct OptionalDefaultOptic<Wrapped>: OptionalOptic {
	public typealias Whole = Optional<Wrapped>
	public typealias Part = Wrapped

	public func tryGet(_ whole: Whole) -> Part? {
		whole
	}

	public func tryUpdate(_ whole: inout Whole, _ f: @escaping (inout Part) -> Void) {
		switch whole {
			case var .some(value):
				f(&value)
				whole = .some(value)
			case .none:
				break
		}
	}
}

extension Optional {
	public static func optic() -> OptionalDefaultOptic<Wrapped> {
		.init()
	}
}
