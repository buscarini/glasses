import Foundation

/// Get all the elements as an array, update them one by one
public protocol ArrayOptic<Whole, Part> {
	associatedtype Whole
	associatedtype Part
		
	func getAll(_ whole: Whole) -> [Part]
	
	func updateAll(_ whole: inout Whole, _ f: @escaping (inout Part) -> Void) -> Void
}

extension ArrayOptic {
	public func setAll(_ whole: inout Whole, to part: Part) -> Void {
		self.updateAll(&whole) { value in
			value = part
		}
	}
	
	func updatingAll(_ whole: Whole, _ f: @escaping (inout Part) -> Void) -> Whole {
		var copy = whole
		self.updateAll(&copy, f)
		return copy
	}

	public func settingAll(_ whole: Whole, to part: Part) -> Whole {
		var copy = whole
		self.setAll(&copy, to: part)
		return copy
	}
}

public struct ArrayDefaultOptic<Element>: ArrayOptic {
	public typealias Whole = Array<Element>
	public typealias Part = Element

	public func getAll(_ whole: Whole) -> [Part] {
		whole
	}

	public func updateAll(_ whole: inout Whole, _ f: @escaping (inout Part) -> Void) {
		whole = whole.map { item in
			var copy = item
			f(&copy)
			return copy
		}
	}
}

public struct DictionaryValuesOptic<Key: Hashable, Value>: ArrayOptic {
	public typealias Whole = Dictionary<Key, Value>
	public typealias Part = Value

	public func getAll(_ whole: Whole) -> [Part] {
		Array(whole.values)
	}

	public func updateAll(_ whole: inout Whole, _ f: @escaping (inout Part) -> Void) {
		whole = whole.mapValues { item in
			var copy = item
			f(&copy)
			return copy
		}
	}
}

extension Array {
	public static func optic() -> ArrayDefaultOptic<Element> {
		.init()
	}
}

extension Dictionary {
	public static func valuesOptic() -> DictionaryValuesOptic<Key, Value> {
		.init()
	}
}

public struct ArrayLensLiftOptic<O: LensOptic, Element>: ArrayOptic
where O.Part == [Element] {
	let lens: O
	
	public typealias Whole = O.Whole
	public typealias Part = Element
	
	public func getAll(_ whole: Whole) -> [Part] {
		lens.get(whole)
	}
	
	public func updateAll(
		_ whole: inout Whole,
		_ f: @escaping (inout Part) -> Void
	) -> Void {
		lens.update(&whole) { elements in
			elements = elements.map { element in
				var copy = element
				f(&copy)
				return copy
			}
		}
	}
}
