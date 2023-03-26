import Foundation

public struct Filter<O: ArrayOptic>: ArrayOptic
where O.NewPart == O.Part, O.NewWhole == O.Whole {
	public typealias Whole = O.Whole
	public typealias NewWhole = O.NewWhole
	public typealias Part = O.Part
	public typealias NewPart = O.NewPart

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

	public func updateAll(
		_ whole: Whole,
		_ f: @escaping (Part) -> NewPart
	) -> NewWhole {
		optic.updateAll(whole) { part in
			guard self.filter(part) else {
				return part
			}

			return f(part)
		}
	}
}
