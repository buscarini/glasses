import Foundation

public struct Last<L: LensOptic, Element>: OptionalOptic where L.Part == [Element], L.NewPart == L.Part {
	public typealias Whole = L.Whole
	public typealias NewWhole = L.NewWhole
	public typealias Part = Element
	public typealias NewPart = Element
	
	public let lens: L
	
	@inlinable
	public init(
		@LensBuilder with build: () -> L
	) {
		self.lens = build()
	}
	
	public func tryGet(_ whole: Whole) -> Part? {
		lens.get(whole).last
	}
	
	public func tryUpdate(
		_ whole: Whole,
		_ f: @escaping (Part) -> NewPart
	) -> NewWhole {
		lens.update(whole) { elements in
			guard let last = elements.last else {
				return elements
			}
			
			var result = elements
			result[result.endIndex.advanced(by: -1)] = f(last)
			return result
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
