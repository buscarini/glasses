//import Foundation
//
//public struct Map<O: ArrayOptic, NewPart>: ArrayOptic {
//	public typealias Whole = O.Whole
//	public typealias Part = NewPart
//	
//	let update: (Part) -> NewPart
//	public let optic: O
//	
//	@inlinable
//	public init(
//		@ArrayOpticBuilder _ build: () -> O,
//		_ update: @escaping (Part) -> NewPart,
//	) {
//		self.optic = build()
//		self.update = update
//	}
//	
//	public func getAll(_ whole: Whole) -> [Part] {
//		optic.getAll(whole).filter(self.filter)
//	}
//	
//	public func updateAll(_ whole: inout Whole, _ f: @escaping (inout Part) -> Void) {
//		optic.updateAll(&whole) { part in
//			guard self.filter(part) else {
//				return
//			}
//			
//			f(&part)
//		}
//	}
//}
//
//
//public struct MapArrayOptic<O: ArrayOptic, NewPart>: ArrayOptic {
//	public typealias Whole = O.Whole
//	public typealias Part = NewPart
//	
//	let update: (Part) -> NewPart
//
//	public init(update: @escaping (Part) -> NewPart) {
//		self.update = update
//	}
//	
//	public func getAll(_ whole: Whole) -> [NewPart] {
//		whole.map(self.update)
//	}
//
//	public func updateAll(_ whole: inout Whole, _ f: @escaping (inout NewPart) -> Void) {
//		whole = whole.map { item in
//			var copy = self.update(item)
//			f(&copy)
//			return copy
//		}
//	}
//}
