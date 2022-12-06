import Foundation

@resultBuilder
public enum LensBuilder {
	public static func buildPartialBlock<O: Lens>(first optic: O) -> O {
		optic
	}
	
	public static func buildPartialBlock<O0: Lens, O1: Lens>(accumulated o0: O0, next o1: O1) -> CombineOptic<O0, O1> {
		CombineOptic(lhs: o0, rhs: o1)
	}
}

extension Lens {
	public func combine<O: Lens>(with optic: O) -> CombineOptic<Self, O>
	where O.Whole == Part
	{
		.init(lhs: self, rhs: optic)
	}
}

public struct CombineOptic<LHS: Lens, RHS: Lens>: Lens
where LHS.Part == RHS.Whole {
	let lhs: LHS
	let rhs: RHS
	
	public typealias Whole = LHS.Whole
	public typealias Part = RHS.Part
	
	public func get(_ whole: LHS.Whole) -> RHS.Part {
		rhs.get(lhs.get(whole))
	}
	
	public func update(
		_ whole: inout LHS.Whole,
		_ f: @escaping (inout RHS.Part) -> Void
	) -> Void {
		lhs.update(&whole) { lhsPart in
			rhs.update(&lhsPart, f)
		}
	}
}

//public struct ConcatLenses<LHS: Lens, RHS: Lens>: Lens
//where LHS.Whole == RHS.Whole, LHS.Part == RHS.Part {
//	let lhs: LHS
//	let rhs: RHS
//	
//	public typealias Whole = LHS.Whole
//	public typealias Part = LHS.Part
//	
//	public func get(_ whole: Whole) -> Part {
//		lhs.get(whole) + rhs.get(whole)
//	}
//	
//	public func update(
//		_ whole: inout Whole,
//		_ f: @escaping (inout Part) -> Void
//	) -> Void {
////		let numLeft = lhs.get(whole).count
//		
//		lhs.update(&whole, f)
//		rhs.update(&whole, f)
//	}
//}


//@resultBuilder
//public enum ConcatLensesBuilder {
//	public static func buildPartialBlock<O: Lens>(first optic: O) -> O {
//		optic
//	}
//	
//	public static func buildPartialBlock<O0: Lens, O1: Lens, Element>(accumulated o0: O0, next o1: O1) -> ConcatLenses<O0, O1, Element> {
//		ConcatLenses(lhs: o0, rhs: o1)
//	}
//}

