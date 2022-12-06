import Foundation

public struct Max<L: LensOptic, Sorted: LensOptic, Element>: OptionalOptic
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
		lens.get(whole).max { left, right in
			self.by.get(left) < self.by.get(right)
		}
	}
	
	public func tryUpdate(_ whole: inout Whole, _ f: @escaping (inout Part) -> Void) {
		lens.update(&whole) { elements in
			guard elements.count > 0 else {
				return
			}

			let indexedMax = zip(0..., elements).max { left, right in
				self.by.get(left.1) < self.by.get(right.1)
			}
			
			guard let index = indexedMax?.0 else {
				return
			}
			
			var item = elements[index]
			f(&item)
			elements[index] = item
		}
	}
}
