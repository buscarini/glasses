import Foundation

public struct First<L: Lens, Element>: OptionalOptic where L.Part == [Element] {
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
		lens.get(whole).first
	}
	
	public func tryUpdate(_ whole: inout Whole, _ f: @escaping (inout Part) -> Void) {
		lens.update(&whole) { elements in
			guard elements.count > 0 else {
				return
			}
			
			var first = elements[0]
			f(&first)
			elements[0] = first
		}
	}
}
