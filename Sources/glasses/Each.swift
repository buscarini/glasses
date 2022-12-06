import Foundation

//public struct Each<L: Lens, Element>: Lens where L.Part == [Element] {
//	public typealias Whole = L.Whole
//	public typealias Part = Element
//	
//	public let lens: L
//	
//	@inlinable
//	public init(
//		@EachOpticBuilder with build: () -> Optics,
//	) {
//		self.lens = build()
//	}
//	
//	public func get(_ whole: Whole) -> [Part] {
//		optics.getAll(whole).filter(self.filter)
//	}
//	
//	public func updateAll(_ whole: inout Whole, _ f: @escaping (inout Part) -> Void) {
//		optics.updateAll(&whole) { part in
//			guard self.filter(part) else {
//				return
//			}
//			
//			f(&part)
//		}
//	}
//}
