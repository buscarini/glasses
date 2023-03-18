import Foundation

public struct Concat<Optics: ArrayOptic>: ArrayOptic {
	public typealias Whole = Optics.Whole
	public typealias Part = Optics.Part
	
	public let lens: Optics
	public let filter: (Part) -> Bool
	
	@inlinable
	public init(
		@ConcatLensesBuilder with build: () -> Optics,
		where filter: @escaping (Part) -> Bool = { _ in true }
	) {
		self.lens = build()
		self.filter = filter
	}
	
	public func getAll(_ whole: Whole) -> [Part] {
		lens.getAll(whole).filter(self.filter)
	}
	
	public func updateAll(_ whole: inout Whole, _ f: @escaping (inout Part) -> Void) {
		lens.updateAll(&whole) { element in
			guard self.filter(element) else {
				return
			}
			
			f(&element)
		}
	}
}

public struct ConcatLenses<LHS: ArrayOptic, RHS: ArrayOptic>: ArrayOptic
where LHS.Whole == RHS.Whole, LHS.Part == RHS.Part {
	let lhs: LHS
	let rhs: RHS
	
	public typealias Whole = LHS.Whole
	public typealias Part = LHS.Part
	
	public func getAll(_ whole: Whole) -> [Part] {
		lhs.getAll(whole) + rhs.getAll(whole)
	}
	
	public func updateAll(
		_ whole: inout Whole,
		_ f: @escaping (inout Part) -> Void
	) -> Void {
		lhs.updateAll(&whole, f)
		rhs.updateAll(&whole, f)
	}
}

@resultBuilder
public enum ConcatLensesBuilder {
	public static func buildPartialBlock<O: LensOptic>(first optic: O) -> ArrayLensLiftOptic<O> {
		ArrayLensLiftOptic(lens: optic)
	}
	
	public static func buildPartialBlock<O: OptionalOptic>(first optic: O) -> ArrayOptionalLiftOptic<O> {
		ArrayOptionalLiftOptic(optic: optic)
	}
	
	public static func buildPartialBlock<O: ArrayOptic>(first optic: O) -> O {
		optic
	}
	
	public static func buildPartialBlock<O0: ArrayOptic, O1: LensOptic>(accumulated o0: O0, next o1: O1) -> ConcatLenses<O0, ArrayLensLiftOptic<O1>> {
		ConcatLenses(
			lhs: o0,
			rhs: ArrayLensLiftOptic(lens: o1)
		)
	}
	
	public static func buildPartialBlock<O0: ArrayOptic, O1: OptionalOptic>(accumulated o0: O0, next o1: O1) -> ConcatLenses<O0, ArrayOptionalLiftOptic<O1>> {
		ConcatLenses(
			lhs: o0,
			rhs: ArrayOptionalLiftOptic(optic: o1)
		)
	}
	
	public static func buildPartialBlock<O0: ArrayOptic, O1: ArrayOptic>(accumulated o0: O0, next o1: O1) -> ConcatLenses<O0, O1> {
		ConcatLenses(lhs: o0, rhs: o1)
	}
}
