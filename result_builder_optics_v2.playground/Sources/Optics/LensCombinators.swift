import Foundation

public struct Optic<Optics: Lens>: Lens {
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
