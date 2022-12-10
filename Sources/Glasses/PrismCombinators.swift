import Foundation

public struct Prism<Optics: PrismOptic>: PrismOptic {
	public typealias Whole = Optics.Whole
	public typealias Part = Optics.Part
	
	public let optics: Optics
	
	@inlinable
	public init(
		@PrismBuilder with build: () -> Optics
	) {
		self.optics = build()
	}
	
	public func extract(from whole: Optics.Whole) -> Optics.Part? {
		self.optics.extract(from: whole)
	}
	
	public func embed(_ part: Optics.Part) -> Optics.Whole {
		self.optics.embed(part)
	}
}
