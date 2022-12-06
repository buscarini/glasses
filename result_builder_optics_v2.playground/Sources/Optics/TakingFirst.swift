import Foundation

//public struct TakingFirst<Optics: ArrayOptic>: ArrayOptic {
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
//		Array(optics.getAll(whole).prefix(count))
//	}
//
//	public func updateAll(_ whole: inout Whole, _ f: @escaping (inout Part) -> Void) {
//		optics.updateAll(&whole, f)
//	}
//}
