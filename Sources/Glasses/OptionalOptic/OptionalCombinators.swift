import Foundation

public struct Optionally<Optics: OptionalOptic>: OptionalOptic {
	public typealias Whole = Optics.Whole
	public typealias Part = Optics.Part
	
	public let optics: Optics
	
	@inlinable
	public init(
		@OptionalBuilder with build: () -> Optics
	) {
		self.optics = build()
	}
	
	public func tryGet(_ whole: Whole) -> Part? {
		optics.tryGet(whole)
	}
	
	public func tryUpdate(_ whole: inout Whole, _ f: @escaping (inout Part) -> Void) {
		optics.tryUpdate(&whole) { part in
			f(&part)
		}
	}
	
	public func trySet(_ whole: inout Whole, to newValue: Part) {
		optics.trySet(&whole, to: newValue)
	}
}
