import Foundation

public struct Optic<Optics: LensOptic>: LensOptic {
	public typealias Whole = Optics.Whole
	public typealias Part = Optics.Part
	
	public let optics: Optics
	
	@inlinable
	public init(
		@LensBuilder with build: () -> Optics
	) {
		self.optics = build()
	}
	
	public func get(_ whole: Whole) -> Part {
		optics.get(whole)
	}
	
	public func update(_ whole: inout Whole, _ f: @escaping (inout Part) -> Void) {
		optics.update(&whole) { part in
			f(&part)
		}
	}
}


public struct LensCombination<LHS: LensOptic, RHS: LensOptic>: LensOptic
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

public struct LensEachCombinator<LHS: LensOptic, RHS: LensOptic>: LensOptic
where LHS.Part == [RHS.Whole] {
	let lhs: LHS
	let rhs: RHS
	
	public typealias Whole = LHS.Whole
	public typealias Part = [RHS.Part]
	
	public func get(_ whole: LHS.Whole) -> [RHS.Part] {
		lhs.get(whole).map(rhs.get)
	}
	
	public func update(
		_ whole: inout LHS.Whole,
		_ f: @escaping (inout [RHS.Part]) -> Void
	) -> Void {
		lhs.update(&whole) { rhsWholes in
			var rhsParts = rhsWholes.map(rhs.get)
			f(&rhsParts)
			rhsWholes = zip(rhsWholes, rhsParts).map { (whole, part) in
				var result = whole
				rhs.update(&result, { $0 = part })
				return result
			}

			
//			rhsWholes.updateInPlace { elements in
//
////				var rhsParts = elements.map(rhs.get)
////				f(&rhsParts)
//
//			} prepare: { _ in
//
//			}

			
		
//			rhs.update(&lhsPart) {
				
//			}
//			lhsPart = lhsPart.map { part in
//				var copy = part
//				rhs.update(&copy, f)
//				return copy
//			}
		}
	}
}

//// MARK: Concat
//public struct Concat<Optics: Lens, Element>: Lens
//where Optics.Part == [Element] {
//	public typealias Whole = Optics.Whole
//	public typealias Part = Optics.Part
//	
//	public let optics: Optics
//	public let filter: (Element) -> Bool
//	
//	@inlinable
//	public init(
//		@ConcatLensesBuilder with build: () -> Optics,
//		where filter: @escaping (Element) -> Bool = { _ in true }
//	) {
//		self.optics = build()
//		self.filter = filter
//	}
//	
//	public func get(_ whole: Whole) -> Part {
//		optics.get(whole).filter(self.filter)
//	}
//	
//	public func update(_ whole: inout Whole, _ f: @escaping (inout Part) -> Void) {
//		optics.update(&whole) { elements in
//			elements = elements.map { element in
//				guard self.filter(element) else {
//					return element
//				}
//				
//				var result = [element]
//				f(&result)
//				return result.first!
//			}
//		}
//	}
//}

//public struct Default<Optics: Optic, WrappedPart>: Optic
//where Optics.Part == Optional<WrappedPart> {
//	public typealias Whole = Optics.Whole
//	public typealias Part = Optics.Part
//
//	public let optics: Optics
//	public let value: Part
//
//	@inlinable
//	public init(
//		_ value: Part,
//		@OpticBuilder with build: () -> Optics
//	) {
//		self.optics = build()
//		self.value = value
//	}
//
//	public func get(_ whole: Whole) -> Part {
//		optics.get(whole)
//	}
//
//	public func update(_ whole: inout Whole, _ f: @escaping (inout Part) -> Void) {
//		optics.update(&whole) { part in
//
//			f(part ?? self.value)
//
////			f(&part)
//		}
//	}
//}
