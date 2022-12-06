import Foundation

public struct DroppingFirst<L: Lens, Element>: Lens
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
		optics.get(whole).dropFirst(self.count)
	}
	
	public func update(_ whole: inout Whole, _ f: @escaping (inout Part) -> Void) {
		optics.update(&whole) { elements in
			fatalError()
//			elements.updateInPlace(update: f) { indexed in
//				indexed = indexed.filter { filter($0.1) }
//			}
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
