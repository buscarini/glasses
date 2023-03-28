import Foundation

@resultBuilder
public enum OptionalBuilder {
	public static func buildPartialBlock<O: LensOptic>(first optic: O) -> OptionalLiftOptic<O> {
		.init(optic: optic)
	}
	
	public static func buildPartialBlock<O: PrismOptic>(first optic: O) -> OptionalLiftPrismOptic<O> {
		.init(prism: optic)
	}
	
	public static func buildPartialBlock<O: OptionalOptic>(first optic: O) -> O {
		optic
	}
	
	public static func buildPartialBlock<O0: OptionalOptic, O1: LensOptic>(accumulated o0: O0, next o1: O1) -> CombineOptionals<O0, OptionalLiftOptic<O1>> {
		CombineOptionals(lhs: o0, rhs: OptionalLiftOptic(optic: o1))
	}
	
	public static func buildPartialBlock<O0: OptionalOptic, O1: PrismOptic>(accumulated o0: O0, next o1: O1) -> CombineOptionals<O0, OptionalLiftPrismOptic<O1>> {
		CombineOptionals(lhs: o0, rhs: OptionalLiftPrismOptic(prism: o1))
	}
	
	public static func buildPartialBlock<O0: OptionalOptic, O1: OptionalOptic>(accumulated o0: O0, next o1: O1) -> CombineOptionals<O0, O1> {
		CombineOptionals(lhs: o0, rhs: o1)
	}
}

public struct OptionalLiftOptic<O: LensOptic>: OptionalOptic {
	let lens: O
	
	public typealias Whole = O.Whole
	public typealias NewWhole = O.NewWhole
	public typealias Part = O.Part
	public typealias NewPart = O.NewPart
	
	public init(optic: O) {
		self.lens = optic
	}
	
	public func tryGet(_ whole: Whole) -> Part? {
		lens.get(whole)
	}
	
	public func tryUpdate(
		_ whole: Whole,
		_ f: @escaping (Part) -> NewPart
	) -> NewWhole {
		lens.update(whole, f)
	}
	
	public func trySet(
		_ whole: Whole,
		to newValue: NewPart
	) -> NewWhole {
		tryUpdate(whole) { _ in
			newValue
		}
	}
}

public struct CombineLensOptional<LHS: LensOptic, RHS: OptionalOptic>: OptionalOptic
where LHS.Part == RHS.Whole, LHS.NewPart == RHS.NewWhole {
	let lhs: LHS
	let rhs: RHS
	
	public typealias Whole = LHS.Whole
	public typealias NewWhole = LHS.NewWhole
	public typealias Part = RHS.Part
	public typealias NewPart = RHS.NewPart
	
	public init(lhs: LHS, rhs: RHS) {
		self.lhs = lhs
		self.rhs = rhs
	}
	
	public func tryGet(_ whole: LHS.Whole) -> RHS.Part? {
		rhs.tryGet(lhs.get(whole))
	}
	
	public func tryUpdate(
		_ whole: Whole,
		_ f: @escaping (Part) -> NewPart
	) -> NewWhole {
		lhs.update(whole) { lhsPart in
			rhs.tryUpdate(lhsPart, f)
		}
	}
	
	public func trySet(
		_ whole: Whole,
		to newValue: NewPart
	) -> NewWhole {
		tryUpdate(whole) { _ in
			newValue
		}
	}
}

public struct CombineOptionals<LHS: OptionalOptic, RHS: OptionalOptic>: OptionalOptic
where LHS.Part == RHS.Whole, LHS.NewPart == RHS.NewWhole {
	let lhs: LHS
	let rhs: RHS
	
	public typealias Whole = LHS.Whole
	public typealias NewWhole = LHS.NewWhole
	public typealias Part = RHS.Part
	public typealias NewPart = RHS.NewPart
	
	public init(lhs: LHS, rhs: RHS) {
		self.lhs = lhs
		self.rhs = rhs
	}
	
	public func tryGet(_ whole: LHS.Whole) -> RHS.Part? {
		lhs.tryGet(whole).flatMap(rhs.tryGet)
	}
	
	public func tryUpdate(
		_ whole: Whole,
		_ f: @escaping (Part) -> NewPart
	) -> NewWhole {
		lhs.tryUpdate(whole) { lhsPart in
			rhs.tryUpdate(lhsPart, f)
		}
	}
	
	public func trySet(
		_ whole: Whole,
		to newValue: NewPart
	) -> NewWhole {
		lhs.tryUpdate(whole) { part in
			rhs.trySet(part, to: newValue)
		}
	}
}
