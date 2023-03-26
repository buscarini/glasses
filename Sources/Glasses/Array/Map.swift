import Foundation

public struct Map<O: ArrayOptic, MappedPart, MappedNewPart>: ArrayOptic {
	public typealias Whole = O.Whole
	public typealias NewWhole = O.NewWhole
	public typealias Part = MappedPart
	public typealias NewPart = MappedNewPart
	
	public let optic: O
	@usableFromInline let to: (O.Part) -> MappedPart
	@usableFromInline let from: (O.Part, MappedNewPart) -> O.NewPart
	
	@inlinable
	public init(
		@ArrayOpticBuilder _ build: () -> O,
		to: @escaping (O.Part) -> MappedPart,
		from: @escaping (O.Part, MappedNewPart) -> O.NewPart
	) {
		self.optic = build()
		self.to = to
		self.from = from
	}
	
	public func getAll(_ whole: Whole) -> [Part] {
		optic.getAll(whole).map(to)
	}
	
	public func updateAll(
		_ whole: Whole,
		_ f: @escaping (Part) -> NewPart
	) -> NewWhole {
		optic.updateAll(whole) { oPart in
			from(oPart, f(to(oPart)))
		}
	}
}
