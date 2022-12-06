import Foundation

public struct Each<Optics: ArrayOptic>: ArrayOptic {
	public typealias Whole = Optics.Whole
	public typealias Part = Optics.Part
	
	public let optics: Optics
	public let filter: (Part) -> Bool
	
	@inlinable
	public init(
		@EachOpticBuilder with build: () -> Optics,
		where filter: @escaping (Part) -> Bool = { _ in true }
	) {
		self.optics = build()
		self.filter = filter
	}
	
	public func getAll(_ whole: Whole) -> [Part] {
		optics.getAll(whole).filter(self.filter)
	}
	
	public func updateAll(_ whole: inout Whole, _ f: @escaping (inout Part) -> Void) {
		optics.updateAll(&whole) { part in
			guard self.filter(part) else {
				return
			}
			
			f(&part)
		}
	}
}
