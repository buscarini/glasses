import Foundation

public struct Filter<O: ArrayOptic>: ArrayOptic {
	public typealias Whole = O.Whole
	public typealias Part = O.Part
	
	public let filter: (Part) -> Bool
	public let optic: O
	
	@inlinable
	public init(
		filter: @escaping (Part) -> Bool,
		@ArrayOpticBuilder with build: () -> O
	) {
		self.filter = filter
		self.optic = build()
	}
	
	public func getAll(_ whole: Whole) -> [Part] {
		optic.getAll(whole).filter(self.filter)
	}
	
	public func updateAll(_ whole: inout Whole, _ f: @escaping (inout Part) -> Void) {
		optic.updateAll(&whole) { part in
			guard self.filter(part) else {
				return
			}
			
			f(&part)
		}
	}
}
