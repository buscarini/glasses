import Foundation

public struct Each<L: LensOptic, Element>: ArrayOptic where L.Part == [Element] {
	public typealias Whole = L.Whole
	public typealias Part = Element
	
	public let lens: L
	
	@inlinable
	public init(
		@LensBuilder with build: () -> L
	) {
		self.lens = build()
	}
	
	public func getAll(_ whole: Whole) -> [Part] {
		lens.get(whole)
	}
	
	public func updateAll(_ whole: inout Whole, _ f: @escaping (inout Part) -> Void) {
		lens.update(&whole) { parts in
			parts = parts.map {
				var copy = $0
				f(&copy)
				return copy
			}
		}
	}
}
