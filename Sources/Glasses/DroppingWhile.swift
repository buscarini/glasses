import Foundation

//public struct DroppingWhile<Optics: ArrayOptic>: ArrayOptic
//where Optics.Part: Equatable {
//	public typealias Whole = Optics.Whole
//	public typealias Part = Optics.Part
//
//	public let condition: (Part) -> Bool
//	public let optics: Optics
//
//	@inlinable
//	public init(
//		@ArrayOpticBuilder with build: () -> Optics,
//		while condition: @escaping (Part) -> Bool
//	) {
//		self.condition = condition
//		self.optics = build()
//	}
//
//	public func getAll(_ whole: Whole) -> [Part] {
//		Array(optics.getAll(whole).drop(while: condition))
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
