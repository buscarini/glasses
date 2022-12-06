import Foundation

public struct Concat<Optics: Lens, Element>: Lens
where Optics.Part == [Element] {
	public typealias Whole = Optics.Whole
	public typealias Part = Optics.Part
	
	public let optics: Optics
	public let filter: (Element) -> Bool
	
	@inlinable
	public init(
		@ConcatLensesBuilder with build: () -> Optics,
		where filter: @escaping (Element) -> Bool = { _ in true }
	) {
		self.optics = build()
		self.filter = filter
	}
	
	public func get(_ whole: Whole) -> Part {
		optics.get(whole).filter(self.filter)
	}
	
	public func update(_ whole: inout Whole, _ f: @escaping (inout Part) -> Void) {
		optics.update(&whole) { elements in
			elements.updateInPlace(update: f) { indexed in
				indexed = indexed.filter { filter($0.1) }
			}
		}
	}
}

public struct ConcatLenses<LHS: Lens, RHS: Lens, Element>: Lens
where LHS.Whole == RHS.Whole, LHS.Part == RHS.Part, LHS.Part == [Element] {
	let lhs: LHS
	let rhs: RHS
	
	public typealias Whole = LHS.Whole
	public typealias Part = LHS.Part
	
	public func get(_ whole: Whole) -> Part {
		lhs.get(whole) + rhs.get(whole)
	}
	
	public func update(
		_ whole: inout Whole,
		_ f: @escaping (inout Part) -> Void
	) -> Void {
		let left = lhs.get(whole)
		let right = rhs.get(whole)
		var combined = left + right

		f(&combined)

		lhs.update(&whole) { leftArray in
			leftArray = Array(combined.prefix(left.count))
		}
		rhs.update(&whole) { rightArray in
			rightArray = Array(combined.dropFirst(left.count))
		}
	}
}

@resultBuilder
public enum ConcatLensesBuilder {
	public static func buildPartialBlock<O: Lens>(first optic: O) -> O {
		optic
	}
	
	public static func buildPartialBlock<O0: Lens, O1: Lens, Element>(accumulated o0: O0, next o1: O1) -> ConcatLenses<O0, O1, Element> {
		ConcatLenses(lhs: o0, rhs: o1)
	}
}