import Foundation

@resultBuilder
public enum LensBuilder {
	public static func buildPartialBlock<O: LensOptic>(first optic: O) -> O {
		optic
	}
	
	public static func buildPartialBlock<O0: LensOptic, O1: LensOptic>(accumulated o0: O0, next o1: O1) -> LensCombination<O0, O1> {
		LensCombination(lhs: o0, rhs: o1)
	}
	
	public static func buildPartialBlock<O0: LensOptic, O1: LensOptic>(accumulated o0: O0, next o1: O1) -> LensEachCombinator<O0, O1> where O0.Part == [O1.Whole] {
		LensEachCombinator(lhs: o0, rhs: o1)
	}
}

extension LensOptic {
	public func combine<O: LensOptic>(with optic: O) -> LensCombination<Self, O>
	where O.Whole == Part
	{
		.init(lhs: self, rhs: optic)
	}
}

public struct Lens<L: LensOptic>: LensOptic {
	public typealias Whole = L.Whole
	public typealias NewWhole = L.NewWhole
	public typealias Part = L.Part
	public typealias NewPart = L.NewPart
	
	public let lens: L
	
	@inlinable
	public init(
		@LensBuilder with build: () -> L
	) {
		self.lens = build()
	}
	
	public func get(_ whole: L.Whole) -> L.Part {
		lens.get(whole)
	}
	
	public func update(_ whole: L.Whole, _ f: @escaping (L.Part) -> L.NewPart) -> L.NewWhole {
		lens.update(whole, f)
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

