import Foundation

public struct Optic<Optics: LensOptic>: LensOptic {
	public typealias Whole = Optics.Whole
	public typealias NewWhole = Optics.NewWhole
	public typealias Part = Optics.Part
	public typealias NewPart = Optics.NewPart
	
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
	
	public func update(_ whole: Whole, _ f: @escaping (Part) -> NewPart) -> NewWhole {
		optics.update(whole, f)
	}
}


public struct LensCombination<LHS: LensOptic, RHS: LensOptic>: LensOptic
where LHS.Part == RHS.Whole, LHS.NewPart == RHS.NewWhole {
	let lhs: LHS
	let rhs: RHS
	
	public typealias Whole = LHS.Whole
	public typealias NewWhole = LHS.NewWhole
	public typealias Part = RHS.Part
	public typealias NewPart = RHS.NewPart
	
	public func get(_ whole: LHS.Whole) -> RHS.Part {
		rhs.get(lhs.get(whole))
	}
	
	public func update(
		_ whole: Whole,
		_ f: @escaping (Part) -> NewPart
	) -> NewWhole {
		lhs.update(whole) { lhsPart in
			rhs.update(lhsPart, f)
		}
	}
}

public struct LensEachCombinator<LHS: LensOptic, RHS: LensOptic>: LensOptic
where LHS.Part == [RHS.Whole], LHS.NewPart == [RHS.NewWhole] {
	let lhs: LHS
	let rhs: RHS
	
	public typealias Whole = LHS.Whole
	public typealias NewWhole = LHS.NewWhole
	public typealias Part = [RHS.Part]
	public typealias NewPart = [RHS.NewPart]
	
	public func get(_ whole: LHS.Whole) -> [RHS.Part] {
		lhs.get(whole).map(rhs.get)
	}
	
	public func update(
		_ whole: Whole,
		_ f: @escaping (Part) -> NewPart
	) -> NewWhole {
		lhs.update(whole) { rhsWholes in
			let rhsParts: [RHS.NewPart] = f(rhsWholes.map(rhs.get))
			
			return zip(rhsWholes, rhsParts).map { whole, newPart in
				rhs.update(whole, { _ in newPart })
			}
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
