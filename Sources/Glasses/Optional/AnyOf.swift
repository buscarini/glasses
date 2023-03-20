import Foundation

public struct AnyOf<P: OptionalOptic>: OptionalOptic {
	public typealias Whole = P.Whole
	public typealias Part = P.Part
	
	public let optics: P
	
	@inlinable
	public init(
		@AnyOfBuilder with build: () -> P
	) {
		self.optics = build()
	}
	
	public func tryGet(_ whole: P.Whole) -> P.Part? {
		self.optics.tryGet(whole)
	}
	
	public func tryUpdate(_ whole: inout P.Whole, _ f: @escaping (inout P.Part) -> Void) {
		self.optics.tryUpdate(&whole, f)
	}
	
	public func trySet(_ whole: inout P.Whole, to newValue: P.Part) {
		self.optics.trySet(&whole, to: newValue)
	}
}

@resultBuilder
public enum AnyOfBuilder {
	public static func buildPartialBlock<O: PrismOptic>(first optic: O) -> O {
		optic
	}
	
	public static func buildPartialBlock<O0: PrismOptic, O1: PrismOptic>(accumulated o0: O0, next o1: O1) -> AnyOfPrisms<O0, O1>
	where O0.Whole == O1.Whole, O0.Part == O1.Part {
		AnyOfPrisms(lhs: o0, rhs: o1)
	}
	
	public static func buildPartialBlock<O0: OptionalOptic, O1: PrismOptic>(accumulated o0: O0, next o1: O1) -> AnyOfOptionalPrism<O0, O1>
	where O0.Whole == O1.Whole, O0.Part == O1.Part {
		AnyOfOptionalPrism(lhs: o0, rhs: o1)
	}
}

public struct AnyOfPrisms<LHS: PrismOptic, RHS: PrismOptic>: OptionalOptic
where LHS.Whole == RHS.Whole, LHS.Part == RHS.Part {
	let lhs: LHS
	let rhs: RHS

	public typealias Whole = LHS.Whole
	public typealias Part = RHS.Part

	public func tryGet(_ whole: LHS.Whole) -> RHS.Part? {
		lhs.extract(from: whole) ?? rhs.extract(from: whole)
	}
	
	public func tryUpdate(_ whole: inout LHS.Whole, _ f: @escaping (inout RHS.Part) -> Void) {
		lhs.tryUpdate(&whole, f)
		rhs.tryUpdate(&whole, f)
	}
	
	public func trySet(_ whole: inout LHS.Whole, to newValue: RHS.Part) {
		lhs.trySet(&whole, to: newValue)
		rhs.trySet(&whole, to: newValue)
	}
}

public struct AnyOfOptionalPrism<LHS: OptionalOptic, RHS: PrismOptic>: OptionalOptic
where LHS.Whole == RHS.Whole, LHS.Part == RHS.Part {
	let lhs: LHS
	let rhs: RHS

	public typealias Whole = LHS.Whole
	public typealias Part = RHS.Part

	public func tryGet(_ whole: LHS.Whole) -> RHS.Part? {
		lhs.tryGet(whole) ?? rhs.extract(from: whole)
	}
	
	public func tryUpdate(_ whole: inout LHS.Whole, _ f: @escaping (inout RHS.Part) -> Void) {
		lhs.tryUpdate(&whole, f)
		rhs.tryUpdate(&whole, f)
	}
	
	public func trySet(_ whole: inout LHS.Whole, to newValue: RHS.Part) {
		lhs.trySet(&whole, to: newValue)
		rhs.trySet(&whole, to: newValue)
	}
}
