import Foundation

public struct DroppingFirst<L: LensOptic, Element>: LensOptic
where L.Part == [Element], L.NewWhole == L.Whole, L.NewPart == L.Part {
	public typealias Whole = L.Whole
	public typealias Part = L.Part
	public typealias NewPart = L.Part
	public typealias NewWhole = L.Whole
	
	public var count: Int
	public var lens: L
	
	@inlinable
	public init(
		count: Int = 1,
		@LensBuilder with build: () -> L
	) {
		self.count = count
		self.lens = build()
	}
	
	public func get(_ whole: Whole) -> Part {
		Array(
			lens.get(whole).dropFirst(self.count)
		)
	}
	
	public func update(_ whole: Whole, _ f: @escaping (Part) -> NewPart) -> NewWhole {
		lens.update(whole) { elements in
			var toUpdate = Array(elements.dropFirst(self.count))
			let notUpdated = elements.prefix(self.count)
			toUpdate = f(toUpdate)
			return Array(notUpdated) + toUpdate
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
