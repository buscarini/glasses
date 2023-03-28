//import Foundation
//
//public struct AllOf<P: OptionalOptic>: OptionalOptic {
//	public typealias Whole = P.Whole
//	public typealias NewWhole = P.NewWhole
//	public typealias Part = P.Part
//	public typealias NewPart = P.NewPart
//	
//	public let merge: @escaping (Part, Part) -> Part
//	public let optics: P
//	
//	@inlinable
//	public init(
//		merging: @escaping (Part, Part) -> Part,
//		@AllOfBuilder with build: () -> P
//	) {
//		self.merge = merging
//		self.optics = build()
//	}
//	
//	public func tryGet(_ whole: Whole) -> Part? {
//		self.optics.tryGet(whole)
//	}
//	
//	public func tryUpdate(_ whole: Whole, _ f: @escaping (Part) -> NewPart) -> NewWhole {
//		self.optics.tryUpdate(whole, f)
//	}
//	
//	public func trySet(
//		_ whole: Whole,
//		to newValue: NewPart
//	) -> NewWhole {
//		optics.trySet(whole, to: newValue)
//	}
//}
//
//@resultBuilder
//public enum AllOfBuilder {
//	public static func buildPartialBlock<O: PrismOptic>(first optic: O) -> OptionalLiftOptic<O> {
//		.init(optic: optic)
//	}
//	
//	public static func buildPartialBlock<O0: OptionalOptic, O1: OptionalOptic>(accumulated o0: O0, next o1: O1) -> AllOfOptionals<O0, O1>
//	where O0.Whole == O1.Whole, O0.Part == O1.Part {
//		AnyOfPrisms(lhs: o0, rhs: o1)
//	}
//	
//	public static func buildPartialBlock<O0: OptionalOptic, O1: PrismOptic>(accumulated o0: O0, next o1: O1) -> AnyOfOptionalPrism<O0, O1>
//	where O0.Whole == O1.Whole, O0.Part == O1.Part {
//		AnyOfOptionalPrism(lhs: o0, rhs: o1)
//	}
//}
//
//public struct AllOfOptionals<LHS: OptionalOptic, RHS: OptionalOptic>: OptionalOptic
//where LHS.Whole == RHS.Whole, LHS.Part == RHS.Part, LHS.NewPart == RHS.NewPart, LHS.NewWhole == RHS.NewWhole {
//	let lhs: LHS
//	let rhs: RHS
//
//	public typealias Whole = LHS.Whole
//	public typealias NewWhole = Whole
//	public typealias Part = RHS.Part
//	public typealias NewPart = Part
//
//	public func tryGet(_ whole: LHS.Whole) -> RHS.Part? {
//		lhs.tryGet(whole) ?? rhs.extract(from: whole)
//	}
//	
//	public func tryUpdate(
//		_ whole: LHS.Whole,
//		_ f: @escaping (RHS.Part) -> RHS.Part
//	) -> NewWhole {
//		var result = whole
//		lhs.tryUpdate(&result) { part in
//			part = f(part)
//		}
//		rhs.tryUpdate(&result) { part in
//			part = f(part)
//		}
//		return result
//	}
//	
//	public func trySet(_ whole: LHS.Whole, to newValue: RHS.Part) -> LHS.NewWhole {
//		var copy = whole
//		lhs.trySet(&copy, to: newValue)
//		rhs.trySet(&copy, to: newValue)
//		return copy
//	}
//}
