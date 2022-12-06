import Foundation

public struct DroppingFirst<L: LensOptic, Element>: LensOptic
where L.Part == [Element] {
	public typealias Whole = L.Whole
	public typealias Part = L.Part
	
	public var count: Int
	public var lens: L
	
	@inlinable
	public init(
		count: Int = 1,
		@ConcatLensesBuilder with build: () -> L
	) {
		self.count = count
		self.lens = build()
	}
	
	public func get(_ whole: Whole) -> Part {
		Array(
			lens.get(whole).dropFirst(self.count)
		)
	}
	
	public func update(_ whole: inout Whole, _ f: @escaping (inout Part) -> Void) {
		lens.update(&whole) { elements in
			let before = elements
			var copy = elements
			f(&copy)
			let updated = copy.dropFirst(self.count)
			let notUpdated = before.prefix(self.count)
			elements = Array(notUpdated + updated)
		}
	}
}

extension LensOptic {
	public func droppingFirst<Element>(
		_ count: Int = 1
	) -> DroppingFirst<Self, Element>
	where Part == [Element] {
		DroppingFirst(count: count) {
			self
		}
	}
}

//public struct DroppingFirst<Optics: ArrayOptic>: ArrayOptic
//where Optics.Part: Equatable {
//	public typealias Whole = Optics.Whole
//	public typealias Part = Optics.Part
//
//	public let count: Int
//	public let optics: Optics
//
//	@inlinable
//	public init(
//		_ count: Int,
//		@ArrayOpticBuilder with build: () -> Optics
//	) {
//		self.count = count
//		self.optics = build()
//	}
//
//	public func getAll(_ whole: Whole) -> [Part] {
//		Array(optics.getAll(whole).dropFirst(count))
//	}
//
//	public func updateAll(_ whole: inout Whole, _ f: @escaping (inout Part) -> Void) {
//		let all = getAll(whole)
//		
//		optics.updateAll(&whole) { part in
//			guard all.contains(part) else {
//				return
//			}
//			
//			f(&part)
//		}
//	}
//}
