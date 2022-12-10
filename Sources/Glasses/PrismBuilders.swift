import Foundation

@resultBuilder
public enum PrismBuilder {
	public static func buildPartialBlock<O: PrismOptic>(first optic: O) -> O {
		optic
	}
	
	public static func buildPartialBlock<O0: PrismOptic, O1: PrismOptic>(accumulated o0: O0, next o1: O1) -> CombinePrisms<O0, O1> {
		CombinePrisms(lhs: o0, rhs: o1)
	}
}

public struct CombinePrisms<LHS: PrismOptic, RHS: PrismOptic>: PrismOptic
where LHS.Part == RHS.Whole {
	let lhs: LHS
	let rhs: RHS
	
	public typealias Whole = LHS.Whole
	public typealias Part = RHS.Part
	
	public func extract(from whole: Whole) -> Part? {
		lhs.extract(from: whole).flatMap(rhs.extract(from:))
	}
	
	public func embed(_ part: Part) -> Whole {
		lhs.embed(rhs.embed(part))
	}
}
