import Foundation

public struct At<L: LensOptic, Element>: OptionalOptic
where L.Part == [Element] {
	public typealias Whole = L.Whole
	public typealias Part = Element
	
	public let index: Array.Index
	public let lens: L
	
	@inlinable
	public init(
		_ index: Array.Index,
		@LensBuilder with build: () -> L
	) {
		self.index = index
		self.lens = build()
	}
	
	public func tryGet(_ whole: Whole) -> Part? {
		let results = lens.get(whole)
		
		guard results.count > self.index else {
			return nil
		}
		
		return results[self.index]
	}
	
	public func tryUpdate(_ whole: inout Whole, _ f: @escaping (inout Part) -> Void) {
		lens.update(&whole) { elements in
			guard elements.count > self.index else {
				return
			}
			
			var item = elements[self.index]
			f(&item)
			elements[self.index] = item
		}
	}
}
