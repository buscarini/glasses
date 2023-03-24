import Foundation

/// Get all the elements as an array, update them one by one
public protocol ArrayOptic<Whole, Part, NewPart, NewWhole> {
	associatedtype Whole
	associatedtype NewWhole
	associatedtype Part
	associatedtype NewPart
		
	func getAll(_ whole: Whole) -> [Part]
	
	func updateAll(
		_ whole: Whole,
		_ f: @escaping (Part) -> NewPart
	) -> NewWhole
}

extension ArrayOptic {
	func updateAll(
		_ whole: inout Whole,
		_ f: @escaping (inout Part) -> Void
	) -> Void where NewWhole == Whole, NewPart == Part {
		whole = self.updateAll(whole) { part in
			var copy = part
			f(&copy)
			return copy
		}
	}
}

extension ArrayOptic where NewPart == Part, NewWhole == Whole {
//	func updateAll(
//		_ whole: inout Whole,
//		_ f: @escaping (inout Part) -> Void
//	) -> Void {
//		whole = self.updateAll(whole) { part in
//			var copy = part
//			f(&copy)
//			return copy
//		}
//	}
	
	public func setAll(_ whole: inout Whole, to part: Part) -> Void {
		self.updateAll(&whole) { value in
			value = part
		}
	}
	
	func updatingAll(_ whole: Whole, _ f: @escaping (inout Part) -> Void) -> Whole {
		self.updateAll(whole) { part in
			var copy = part
			f(&copy)
			return copy
		}
	}

	public func settingAll(_ whole: Whole, to part: Part) -> Whole {
		var copy = whole
		self.setAll(&copy, to: part)
		return copy
	}
}

extension ArrayOptic {
	func map<NewPart>(
		from: @escaping (NewPart) -> Part,
		to: @escaping (Part) -> NewPart
	) {
		
		
	}
}

public struct ArrayDefaultOptic<Element, NewElement>: ArrayOptic {
	public typealias Whole = Array<Element>
	public typealias NewWhole = Array<NewElement>
	public typealias Part = Element
	public typealias NewPart = NewElement

	public func getAll(_ whole: Whole) -> [Part] {
		whole
	}

	public func updateAll(
		_ whole: Whole,
		_ f: @escaping (Part) -> NewPart
	) -> NewWhole {
		whole.map(f)
	}
}

public struct DictionaryValuesOptic<Key: Hashable, Value, NewValue>: ArrayOptic {
	public typealias Whole = Dictionary<Key, Value>
	public typealias NewWhole = Dictionary<Key, NewValue>
	public typealias Part = Value
	public typealias NewPart = NewValue

	public func getAll(_ whole: Whole) -> [Part] {
		Array(whole.values)
	}

	public func updateAll(
		_ whole: Whole,
		_ f: @escaping (Part) -> NewPart
	) -> NewWhole {
		whole.mapValues(f)
	}
}

public struct ArrayLensLiftOptic<O: LensOptic>: ArrayOptic {
	let lens: O
	
	public typealias Whole = O.Whole
	public typealias NewWhole = O.NewWhole
	public typealias Part = O.Part
	public typealias NewPart = O.NewPart
	
	public func getAll(_ whole: Whole) -> [Part] {
		[lens.get(whole)]
	}
	
	public func updateAll(
		_ whole: Whole,
		_ f: @escaping (Part) -> NewPart
	) -> NewWhole {
		lens.update(whole, f)
	}
}

public struct ArrayOptionalLiftOptic<O: OptionalOptic>: ArrayOptic {
	let optic: O
	
	public typealias Whole = O.Whole
	public typealias NewWhole = O.NewWhole
	public typealias Part = O.Part
	public typealias NewPart = O.NewPart
	
	public func getAll(_ whole: Whole) -> [Part] {
		[optic.tryGet(whole)].compactMap { $0 }
	}
	
	public func updateAll(
		_ whole: Whole,
		_ f: @escaping (Part) -> NewPart
	) -> NewWhole {
		optic.tryUpdate(whole, f)
	}
}
