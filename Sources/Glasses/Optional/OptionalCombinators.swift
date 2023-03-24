import Foundation

public struct Optionally<Optics: OptionalOptic>: OptionalOptic {
	public typealias Whole = Optics.Whole
	public typealias NewWhole = Optics.NewWhole
	public typealias Part = Optics.Part
	public typealias NewPart = Optics.NewPart
	
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
	
	public func tryUpdate(
		_ whole: Whole,
		_ f: @escaping (Part) -> NewPart
	) -> NewWhole {
		optics.tryUpdate(whole, f)
	}
	
	public func trySet(_ whole: Whole, to newValue: NewPart) -> NewWhole {
		optics.trySet(whole, to: newValue)
	}
}
