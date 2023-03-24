import Foundation

//public struct CombineOpticArray<LHS: Lens, RHS: ArrayOptic>: ArrayOptic
//where LHS.Part == RHS.Whole {
//	let lhs: LHS
//	let rhs: RHS
//
//	public typealias Whole = LHS.Whole
//	public typealias Part = RHS.Part
//
//	public func getAll(_ whole: LHS.Whole) -> [RHS.Part] {
//		rhs.getAll(lhs.get(whole))
//	}
//
//	public func updateAll(
//		_ whole: inout LHS.Whole,
//		_ f: @escaping (inout RHS.Part) -> Void
//	) -> Void {
//		lhs.update(&whole) { lhsPart in
//			rhs.updateAll(&lhsPart, f)
//		}
//	}
//}
//

public struct CombineArrayOptic<LHS: ArrayOptic, RHS: LensOptic>: ArrayOptic
where LHS.Part == RHS.Whole, LHS.NewPart == RHS.NewWhole {
	let lhs: LHS
	let rhs: RHS

	public typealias Whole = LHS.Whole
	public typealias NewWhole = LHS.NewWhole
	public typealias Part = RHS.Part
	public typealias NewPart = RHS.NewPart

	public func getAll(_ whole: LHS.Whole) -> [RHS.Part] {
		lhs.getAll(whole).map(rhs.get)
	}

	public func updateAll(
		_ whole: Whole,
		_ f: @escaping (Part) -> NewPart
	) -> NewWhole {
		lhs.updateAll(whole) { lhsPart in
			rhs.update(lhsPart, f)
		}
	}
}

public struct ConcatArrayOptics<LHS: ArrayOptic, RHS: ArrayOptic>: ArrayOptic
where LHS.Whole == RHS.Whole, LHS.Part == RHS.Part, LHS.NewPart == RHS.NewPart, LHS.NewWhole == RHS.NewWhole, LHS.NewWhole == LHS.Whole {
	let lhs: LHS
	let rhs: RHS

	public init(
		lhs: LHS,
		rhs: RHS
	) {
		self.lhs = lhs
		self.rhs = rhs
	}

	public typealias Whole = LHS.Whole
	public typealias Part = RHS.Part
	public typealias NewPart = RHS.NewPart
	public typealias NewWhole = RHS.NewWhole

	public func getAll(_ whole: LHS.Whole) -> [RHS.Part] {
		lhs.getAll(whole) + rhs.getAll(whole)
	}

	public func updateAll(
		_ whole: Whole,
		_ f: @escaping (Part) -> NewPart
	) -> NewWhole {
		let updated = lhs.updateAll(whole, f)
		return rhs.updateAll(updated, f)
	}
}
//
//public struct CombineOptionalArray<LHS: OptionalOptic, RHS: ArrayOptic>: ArrayOptic
//where LHS.Part == RHS.Whole {
//	let lhs: LHS
//	let rhs: RHS
//
//	public typealias Whole = LHS.Whole
//	public typealias Part = RHS.Part
//
//	public func getAll(_ whole: LHS.Whole) -> [RHS.Part] {
//		guard let value = lhs.tryGet(whole) else {
//			return []
//		}
//
//		return rhs.getAll(value)
//	}
//
//	public func updateAll(
//		_ whole: inout LHS.Whole,
//		_ f: @escaping (inout RHS.Part) -> Void
//	) -> Void {
//		lhs.tryUpdate(&whole) { lhsPart in
//			rhs.updateAll(&lhsPart, f)
//		}
//	}
//}
//
public struct CombineArrayOptional<LHS: ArrayOptic, RHS: OptionalOptic>: ArrayOptic
where LHS.Part == RHS.Whole, LHS.NewPart == RHS.NewWhole {
	let lhs: LHS
	let rhs: RHS

	public typealias Whole = LHS.Whole
	public typealias NewWhole = LHS.NewWhole
	public typealias Part = RHS.Part
	public typealias NewPart = RHS.NewPart

	public func getAll(_ whole: LHS.Whole) -> [RHS.Part] {
		lhs.getAll(whole).compactMap(rhs.tryGet)
	}

	public func updateAll(
		_ whole: Whole,
		_ f: @escaping (Part) -> NewPart
	) -> NewWhole {
		lhs.updateAll(whole) { lhsPart in
			rhs.tryUpdate(lhsPart, f)
		}
	}
}
//
public struct CombineArrayArray<LHS: ArrayOptic, RHS: ArrayOptic>: ArrayOptic
where LHS.Part == RHS.Whole, LHS.NewPart == RHS.NewWhole {
	let lhs: LHS
	let rhs: RHS

	public typealias Whole = LHS.Whole
	public typealias NewWhole = LHS.NewWhole
	public typealias Part = RHS.Part
	public typealias NewPart = RHS.NewPart

	public func getAll(_ whole: LHS.Whole) -> [RHS.Part] {
		lhs.getAll(whole).flatMap(rhs.getAll)
	}

	public func updateAll(
		_ whole: Whole,
		_ f: @escaping (Part) -> NewPart
	) -> NewWhole {
		lhs.updateAll(whole) { lhsPart in
			rhs.updateAll(lhsPart, f)
		}
	}
}
//
//public struct ArrayLiftOptic<O: Lens>: ArrayOptic {
//	let optic: O
//
//	public typealias Whole = O.Whole
//	public typealias Part = O.Part
//
//	public func getAll(_ whole: Whole) -> [Part] {
//		[
//			optic.get(whole)
//		]
//	}
//
//	public func updateAll(
//		_ whole: inout O.Whole,
//		_ f: @escaping (inout O.Part) -> Void
//	) -> Void {
//		optic.update(&whole, f)
//	}
//}
//
//public struct ArrayLiftOptional<O: OptionalOptic>: ArrayOptic {
//	let optic: O
//
//	public typealias Whole = O.Whole
//	public typealias Part = O.Part
//
//	public func getAll(_ whole: Whole) -> [Part] {
//		[
//			optic.tryGet(whole)
//		].compactMap { $0 }
//	}
//
//	public func updateAll(
//		_ whole: inout O.Whole,
//		_ f: @escaping (inout O.Part) -> Void
//	) -> Void {
//		optic.tryUpdate(&whole, f)
//	}
//}
//

@resultBuilder
public enum ArrayOpticBuilder {
	public static func buildPartialBlock<O: LensOptic>(first optic: O) -> ArrayLensLiftOptic<O> {
		.init(lens: optic)
	}

	public static func buildPartialBlock<O: OptionalOptic>(first optic: O) -> ArrayOptionalLiftOptic<O> {
		.init(optic: optic)
	}

	public static func buildPartialBlock<O: ArrayOptic>(first optic: O) -> O {
		optic
	}

//	public static func buildPartialBlock<O0: Lens, O1: Lens>(accumulated o0: O0, next o1: O1) -> ArrayLiftOptic<CombineOptic<O0, O1>> {
//		.init(optic: CombineOptic(lhs: o0, rhs: o1))
//	}

//	public static func buildPartialBlock<O0: Lens, O1: OptionalOptic>(accumulated o0: O0, next o1: O1) -> ArrayLiftOptional<CombineOpticOptional<O0, O1>> {
//		.init(optic: CombineOpticOptional(lhs: o0, rhs: o1))
//	}
//
//	public static func buildPartialBlock<O0: OptionalOptic, O1: Lens>(accumulated o0: O0, next o1: O1) -> ArrayLiftOptional<CombineOptionalOptic<O0, O1>> {
//		.init(optic: CombineOptionalOptic(lhs: o0, rhs: o1))
//	}

//	public static func buildPartialBlock<O0: Lens, O1: ArrayOptic>(accumulated o0: O0, next o1: O1) -> CombineOpticArray<O0, O1> {
//		CombineOpticArray(lhs: o0, rhs: o1)
//	}

	public static func buildPartialBlock<O0: ArrayOptic, O1: LensOptic>(accumulated o0: O0, next o1: O1) -> CombineArrayOptic<O0, O1> {
		CombineArrayOptic(lhs: o0, rhs: o1)
	}

	public static func buildPartialBlock<O0: ArrayOptic, O1: ArrayOptic>(accumulated o0: O0, next o1: O1) -> CombineArrayArray<O0, O1> {
		CombineArrayArray(lhs: o0, rhs: o1)
	}

//	public static func buildPartialBlock<O0: OptionalOptic, O1: ArrayOptic>(accumulated o0: O0, next o1: O1) -> CombineOptionalArray<O0, O1> {
//		CombineOptionalArray(lhs: o0, rhs: o1)
//	}

	public static func buildPartialBlock<O0: ArrayOptic, O1: OptionalOptic>(accumulated o0: O0, next o1: O1) -> CombineArrayOptional<O0, O1> {
		CombineArrayOptional(lhs: o0, rhs: o1)
	}
}
//
//@resultBuilder
//public enum ConcatArrayOpticBuilder {
//	public static func buildPartialBlock<O: Lens>(first optic: O) -> ArrayLiftOptic<O> {
//		.init(optic: optic)
//	}
//
//	public static func buildPartialBlock<O: OptionalOptic>(first optic: O) -> ArrayLiftOptional<O> {
//		.init(optic: optic)
//	}
//
//	public static func buildPartialBlock<O: ArrayOptic>(first optic: O) -> O {
//		optic
//	}
//
//	public static func buildPartialBlock<O0: ArrayOptic, O1: Lens>(accumulated o0: O0, next o1: O1) -> ConcatArrayOptics<O0, ArrayLiftOptic<O1>> {
//		ConcatArrayOptics(lhs: o0, rhs: ArrayLiftOptic(optic: o1))
//	}
//
//	public static func buildPartialBlock<O0: Lens, O1: ArrayOptic>(accumulated o0: O0, next o1: O1) -> ConcatArrayOptics<ArrayLiftOptic<O0>, O1> {
//		ConcatArrayOptics(lhs: ArrayLiftOptic(optic: o0), rhs: o1)
//	}
//
//	public static func buildPartialBlock<O0: ArrayOptic, O1: OptionalOptic>(accumulated o0: O0, next o1: O1) -> ConcatArrayOptics<O0, ArrayLiftOptional<O1>> {
//		ConcatArrayOptics(lhs: o0, rhs: ArrayLiftOptional(optic: o1))
//	}
//
//	public static func buildPartialBlock<O0: OptionalOptic, O1: ArrayOptic>(accumulated o0: O0, next o1: O1) -> ConcatArrayOptics<ArrayLiftOptional<O0>, O1> {
//		ConcatArrayOptics(lhs: ArrayLiftOptional(optic: o0), rhs: o1)
//	}
//
//	public static func buildPartialBlock<O0: ArrayOptic, O1: ArrayOptic>(accumulated o0: O0, next o1: O1) -> ConcatArrayOptics<O0, O1> {
//		ConcatArrayOptics(lhs: o0, rhs: o1)
//	}
//}
//
//// MARK: Zip
//public struct ZipArrayOptics<LHS: ArrayOptic, RHS: ArrayOptic>: ArrayOptic
//where LHS.Whole == RHS.Whole, LHS.Part: Equatable, RHS.Part: Equatable {
//	let lhs: LHS
//	let rhs: RHS
//
//	public typealias Whole = LHS.Whole
//	public typealias Part = (LHS.Part, RHS.Part)
//
//	public func getAll(_ whole: LHS.Whole) -> [(LHS.Part, RHS.Part)] {
//		Array(
//			zip(
//				lhs.getAll(whole),
//				rhs.getAll(whole)
//			)
//		)
//	}
//
//	public func updateAll(
//		_ whole: inout LHS.Whole,
//		_ f: @escaping (inout (LHS.Part, RHS.Part)) -> Void
//	) -> Void {
//		let pairs = self.getAll(whole)
//
//		lhs.updateAll(&whole) { left in
//			let pair = pairs.first(where: { $0.0 == left })
//			f((left, pair.right))
//		}
//
//		rhs.updateAll(&whole) { right in
//			let pair = pairs.first(where: { $0.1 == right })
//			f((pair.right, right))
//		}
//	}
//}
//
//public enum ZipArrayOpticBuilder {
//	public static func buildPartialBlock<O: Optic>(first optic: O) -> ArrayLiftOptic<O> {
//		.init(optic: optic)
//	}
//
//	public static func buildPartialBlock<O: OptionalOptic>(first optic: O) -> ArrayLiftOptional<O> {
//		.init(optic: optic)
//	}
//
//	public static func buildPartialBlock<O: ArrayOptic>(first optic: O) -> O {
//		optic
//	}
//
//	public static func buildPartialBlock<O0: ArrayOptic, O1: Optic>(accumulated o0: O0, next o1: O1) -> ZipArrayOptics<O0, ArrayLiftOptic<O1>> {
//		ZipArrayOptics(lhs: o0, rhs: ArrayLiftOptic(optic: o1))
//	}
//
////	public static func buildPartialBlock<O0: Optic, O1: ArrayOptic>(accumulated o0: O0, next o1: O1) -> ConcatArrayOptics<ArrayLiftOptic<O0>, O1> {
////		ConcatArrayOptics(lhs: ArrayLiftOptic(optic: o0), rhs: o1)
////	}
//
//	public static func buildPartialBlock<O0: ArrayOptic, O1: OptionalOptic>(accumulated o0: O0, next o1: O1) -> ZipArrayOptics<O0, ArrayLiftOptional<O1>> {
//		ZipArrayOptics(lhs: o0, rhs: ArrayLiftOptional(optic: o1))
//	}
//
////	public static func buildPartialBlock<O0: OptionalOptic, O1: ArrayOptic>(accumulated o0: O0, next o1: O1) -> ConcatArrayOptics<ArrayLiftOptional<O0>, O1> {
////		ConcatArrayOptics(lhs: ArrayLiftOptional(optic: o0), rhs: o1)
////	}
//
//	public static func buildPartialBlock<O0: ArrayOptic, O1: ArrayOptic>(accumulated o0: O0, next o1: O1) -> ZipArrayOptics<O0, O1> {
//		ZipArrayOptics(lhs: o0, rhs: o1)
//	}
//}

//

 /*
 
@resultBuilder
public enum EachOpticBuilder {
	public static func buildPartialBlock<O: Lens, Element>(first optic: O) -> ArrayLensLiftOptic<O, Element> {
		.init(lens: optic)
	}
	
	public static func buildPartialBlock<O: ArrayOptic>(first optic: O) -> O {
		optic
	}
	
	public static func buildPartialBlock<O0: Lens, O1: ArrayOptic, Element>(accumulated o0: O0, next o1: O1) -> ConcatArrayOptics<ArrayLensLiftOptic<O0, Element>, O1> {
		ConcatArrayOptics(lhs: ArrayLensLiftOptic(lens: o0), rhs: o1)
	}
	
	public static func buildPartialBlock<O0: ArrayOptic, O1: ArrayOptic>(accumulated o0: O0, next o1: O1) -> ConcatArrayOptics<O0, O1> {
		ConcatArrayOptics(lhs: o0, rhs: o1)
	}

//	public static func buildPartialBlock<O0: Lens, O1: Lens, Element>(accumulated o0: O0, next o1: O1) -> ConcatLenses<O0, O1, Element> {
//		ConcatLenses(lhs: o0, rhs: o1)
//	}
}
  
*/


@resultBuilder
public enum EachOpticBuilder {
	public static func buildPartialBlock<O: LensOptic>(first optic: O) -> ArrayLensLiftOptic<O> {
		.init(lens: optic)
	}
	
	public static func buildPartialBlock<O: ArrayOptic>(first optic: O) -> O {
		optic
	}
	
	public static func buildPartialBlock<O0: LensOptic, O1: ArrayOptic>(accumulated o0: O0, next o1: O1) -> ConcatArrayOptics<ArrayLensLiftOptic<O0>, O1> {
		ConcatArrayOptics(lhs: ArrayLensLiftOptic(lens: o0), rhs: o1)
	}
	
	public static func buildPartialBlock<O0: ArrayOptic, O1: ArrayOptic>(accumulated o0: O0, next o1: O1) -> ConcatArrayOptics<O0, O1> {
		ConcatArrayOptics(lhs: o0, rhs: o1)
	}
}
