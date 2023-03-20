import Foundation

public struct Prism<P: PrismOptic>: PrismOptic {
	public typealias Whole = P.Whole
	public typealias Part = P.Part
	
	public let optics: P
	
	@inlinable
	public init(
		@PrismBuilder with build: () -> P
	) {
		self.optics = build()
	}
	
	public func extract(from whole: P.Whole) -> P.Part? {
		self.optics.extract(from: whole)
	}
	
	public func embed(_ part: P.Part) -> P.Whole {
		self.optics.embed(part)
	}
}
