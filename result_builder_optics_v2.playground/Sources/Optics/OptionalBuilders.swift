import Foundation

public struct OptionalLiftOptic<O: Lens>: OptionalOptic {
	let optic: O
	
	public typealias Whole = O.Whole
	public typealias Part = O.Part
	
	public func tryGet(_ whole: Whole) -> Part? {
		optic.get(whole)
	}
	
	public func tryUpdate(
		_ whole: inout O.Whole,
		_ f: @escaping (inout O.Part) -> Void
	) -> Void {
		optic.update(&whole, f)
	}
}

@resultBuilder
public enum OptionalBuilder {
	public static func buildPartialBlock<O: Lens>(first optic: O) -> OptionalLiftOptic<O> {
		.init(optic: optic)
	}
	
	public static func buildPartialBlock<O: OptionalOptic>(first optic: O) -> O {
		optic
	}
	
	public static func buildPartialBlock<O0: Lens, O1: Lens>(accumulated o0: O0, next o1: O1) -> CombineOptic<O0, O1> {
		CombineOptic(lhs: o0, rhs: o1)
	}
	
	public static func buildPartialBlock<O0: Lens, O1: OptionalOptic>(accumulated o0: O0, next o1: O1) -> CombineOpticOptional<O0, O1> {
		CombineOpticOptional(lhs: o0, rhs: o1)
	}
	
	public static func buildPartialBlock<O0: OptionalOptic, O1: Lens>(accumulated o0: O0, next o1: O1) -> CombineOptionalOptic<O0, O1> {
		CombineOptionalOptic(lhs: o0, rhs: o1)
	}
}

public struct CombineOpticOptional<LHS: Lens, RHS: OptionalOptic>: OptionalOptic
where LHS.Part == RHS.Whole {
	let lhs: LHS
	let rhs: RHS
	
	public typealias Whole = LHS.Whole
	public typealias Part = RHS.Part
	
	public func tryGet(_ whole: LHS.Whole) -> RHS.Part? {
		rhs.tryGet(lhs.get(whole))
	}
	
	public func tryUpdate(
		_ whole: inout LHS.Whole,
		_ f: @escaping (inout RHS.Part) -> Void
	) -> Void {
		lhs.update(&whole) { lhsPart in
			rhs.tryUpdate(&lhsPart, f)
		}
	}
}

public struct CombineOptionalOptic<LHS: OptionalOptic, RHS: Lens>: OptionalOptic
where LHS.Part == RHS.Whole {
	let lhs: LHS
	let rhs: RHS
	
	public typealias Whole = LHS.Whole
	public typealias Part = RHS.Part
	
	public func tryGet(_ whole: LHS.Whole) -> RHS.Part? {
		lhs.tryGet(whole).map(rhs.get)
	}
	
	public func tryUpdate(
		_ whole: inout LHS.Whole,
		_ f: @escaping (inout RHS.Part) -> Void
	) -> Void {
		lhs.tryUpdate(&whole) { lhsPart in
			rhs.update(&lhsPart, f)
		}
	}
}
