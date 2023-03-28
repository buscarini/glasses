import Foundation

public protocol OptionalOptic<Whole, Part, NewWhole, NewPart> {
	associatedtype Whole
	associatedtype NewWhole
	associatedtype Part
	associatedtype NewPart
		
	func tryGet(_ whole: Whole) -> Part?
	
	func tryUpdate(_ whole: Whole, _ f: @escaping (Part) -> NewPart) -> NewWhole
	
	func trySet(_ whole: Whole, to: NewPart) -> NewWhole
}

public typealias SimpleOptionalOptic<Whole, Part> = OptionalOptic<Whole, Part, Whole, Part>

extension OptionalOptic {
	public func tryUpdate(
		_ whole: inout Whole,
		_ f: @escaping (inout Part) -> Void
	) -> Void
	where Part == NewPart, Whole == NewWhole {
		whole = self.tryUpdate(whole, { part in
			var copy = part
			f(&copy)
			return copy
		})
	}
	
	public func tryUpdate(
		_ whole: Whole,
		_ f: @escaping (inout Part) -> Void
	) -> Whole
	where Part == NewPart, Whole == NewWhole {
		self.tryUpdate(whole) { part in
			var result = part
			f(&result)
			return result
		}
	}
	
	public func tryUpdate(
		_ whole: inout Whole,
		_ f: @escaping (Part) -> NewPart
	) -> Void
	where Part == NewPart, Whole == NewWhole {
		self.tryUpdate(&whole) { part in
			part = f(part)
		}
	}
	
	public func trySet(
		_ whole: inout Whole,
		to newPart: NewPart
	)  where Part == NewPart, Whole == NewWhole {
		whole = self.trySet(whole, to: newPart)
	}
	
	public func trySetting(
		_ whole: Whole,
		to newValue: NewPart
	) -> Whole where Part == NewPart, Whole == NewWhole {
		var copy = whole
		self.trySet(&copy, to: newValue)
		return copy
	}
}

public struct OptionalRawOptic<Whole, Part, NewWhole, NewPart>: OptionalOptic {
	public let _tryGet: (Whole) -> Part?
	public let _tryUpdate: (Whole, @escaping (Part) -> NewPart) -> NewWhole
	public let _trySet: (Whole, NewPart) -> NewWhole
	
	public init(
		tryGet: @escaping (Whole) -> Part?,
		tryUpdate: @escaping (Whole, @escaping (Part) -> NewPart) -> NewWhole,
		trySet: @escaping (Whole, NewPart) -> NewWhole
	) {
		self._tryGet = tryGet
		self._tryUpdate = tryUpdate
		self._trySet = trySet
	}
	
	public func tryGet(_ whole: Whole) -> Part? {
		_tryGet(whole)
	}

	public func tryUpdate(
		_ whole: Whole,
		_ f: @escaping (Part) -> NewPart
	) -> NewWhole {
		_tryUpdate(whole, f)
	}
	
	public func trySet(
		_ whole: Whole,
		to newValue: NewPart
	) -> NewWhole {
		_trySet(whole, newValue)
	}
}

public struct OptionalDefaultOptic<Wrapped, NewWrapped>: OptionalOptic {
	public typealias Whole = Optional<Wrapped>
	public typealias NewWhole = Optional<NewWrapped>
	public typealias Part = Wrapped
	public typealias NewPart = NewWrapped

	public func tryGet(_ whole: Whole) -> Part? {
		whole
	}

	public func tryUpdate(
		_ whole: Whole,
		_ f: @escaping (Part) -> NewPart
	) -> NewWhole {
		switch whole {
			case let .some(value):
				return .some(f(value))
			case .none:
				return .none
		}
	}
	
	public func trySet(
		_ whole: Whole,
		to newValue: NewPart
	) -> NewWhole {
		tryUpdate(whole) { _ in
			newValue
		}
	}
}

public struct OptionalLiftPrismOptic<P: PrismOptic>: OptionalOptic {
	public typealias Whole = P.Whole
	public typealias NewWhole = Whole
	public typealias Part = P.Part
	public typealias NewPart = Part
	
	public let prism: P
	
	public init(prism: P) {
		self.prism = prism
	}
	
	public func tryGet(_ whole: Whole) -> Part? {
		prism.extract(from: whole)
	}
	
	public func tryUpdate(_ whole: Whole, _ f: @escaping (Part) -> NewPart) -> NewWhole {
		guard var value = prism.extract(from: whole) else {
			return whole
		}
		
		value = f(value)
		
		return prism.embed(value)
	}
	
	public func trySet(
		_ whole: Whole,
		to newValue: NewPart
	) -> NewWhole {
		prism.embed(newValue)
	}
}
