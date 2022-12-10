import Foundation

public struct Last<L: LensOptic, Element>: OptionalOptic where L.Part == [Element] {
	public typealias Whole = L.Whole
	public typealias Part = Element
	
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
	
	public func tryUpdate(_ whole: inout Whole, _ f: @escaping (inout Part) -> Void) {
		lens.update(&whole) { elements in
			guard elements.count > 0 else {
				return
			}
			
			var last = elements.last!
			f(&last)
			elements[elements.endIndex.advanced(by: -1)] = last
		}
	}
	
	public func trySet(_ whole: inout Whole, newValue: Part) {
		tryUpdate(&whole) { part in
			part = newValue
		}
	}
}
