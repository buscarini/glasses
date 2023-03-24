import Foundation

public struct Max<L: LensOptic, Sorted: LensOptic, Element>: OptionalOptic
where L.Part == [Element], Sorted.Whole == Element, Sorted.Part: Comparable, L.NewPart == L.Part, L.NewWhole == L.Whole {
	public typealias Whole = L.Whole
	public typealias NewWhole = L.NewWhole
	public typealias Part = Element
	public typealias NewPart = Part
	
	public let lens: L
	public let by: Sorted
	
	@inlinable
	public init(
		@LensBuilder with build: () -> L,
		@LensBuilder by: () -> Sorted
	) {
		self.lens = build()
		self.by = by()
	}
	
	public func tryGet(_ whole: Whole) -> Part? {
		lens.get(whole).max { left, right in
			self.by.get(left) < self.by.get(right)
		}
	}
	
	public func tryUpdate(
		_ whole: Whole,
		_ f: @escaping (Part) -> NewPart
	) -> NewWhole {
		lens.update(whole) { elements in
			guard elements.count > 0 else {
				return elements
			}

			let indexedMax = zip(0..., elements).max { left, right in
				self.by.get(left.1) < self.by.get(right.1)
			}
			
			guard let index = indexedMax?.0 else {
				return elements
			}
			
			var result = elements
			result[index] = f(result[index])
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
