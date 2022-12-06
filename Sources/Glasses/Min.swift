import Foundation

public struct Min<L: LensOptic, Sorted: LensOptic, Element>: OptionalOptic
where L.Part == [Element], Sorted.Whole == Element, Sorted.Part: Comparable {
	public typealias Whole = L.Whole
	public typealias Part = Element
	
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
		lens.get(whole).min { left, right in
			self.by.get(left) < self.by.get(right)
		}
	}
	
	public func tryUpdate(_ whole: inout Whole, _ f: @escaping (inout Part) -> Void) {
		lens.update(&whole) { elements in
			guard elements.count > 0 else {
				return
			}

			let indexedMax = zip(0..., elements).min { left, right in
				self.by.get(left.1) < self.by.get(left.1)
			}
			
			guard let index = indexedMax?.0 else {
				return
			}
			
			var first = elements[index]
			f(&first)
			elements[index] = first
		}
	}
}
