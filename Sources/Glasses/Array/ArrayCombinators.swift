import Foundation

public struct Many<Optics: ArrayOptic>: ArrayOptic {
	public typealias Whole = Optics.Whole
	public typealias NewWhole = Optics.NewWhole
	public typealias Part = Optics.Part
	public typealias NewPart = Optics.NewPart
	
	public let optics: Optics
	
	@inlinable
	public init(
		@ArrayOpticBuilder with build: () -> Optics
	) {
		self.optics = build()
	}
	
	public func getAll(_ whole: Whole) -> [Part] {
		optics.getAll(whole)
	}
	
	public func updateAll(
		_ whole: Whole,
		_ f: @escaping (Part) -> NewPart
	) -> NewWhole {
		optics.updateAll(whole, f)
	}
}

// MARK: Array -> Optional
//public struct First<Optics: ArrayOptic>: OptionalOptic where Optics.Part: Equatable {
//	public typealias Whole = Optics.Whole
//	public typealias Part = Optics.Part
//	
//	public let optics: Optics
//	
//	@inlinable
//	public init(
//		@ArrayOpticBuilder with build: () -> Optics
//	) {
//		self.optics = build()
//		
//	}
//	
//	public func tryGet(_ whole: Whole) -> Part? {
//		optics.getAll(whole).first
//	}
//	
//	public func tryUpdate(_ whole: inout Whole, _ f: @escaping (inout Part) -> Void) {
//		guard let toUpdate = self.tryGet(whole) else {
//			return
//		}
//		
//		optics.updateAll(&whole) { part in
//			guard part == toUpdate else {
//				return
//			}
//			
//			f(&part)
//		}
//	}
//}

//public struct Last<Optics: ArrayOptic>: OptionalOptic where Optics.Part: Equatable {
//	public typealias Whole = Optics.Whole
//	public typealias Part = Optics.Part
//
//	public let optics: Optics
//
//	@inlinable
//	public init(
//		@ArrayOpticBuilder with build: () -> Optics
//	) {
//		self.optics = build()
//
//	}
//
//	public func tryGet(_ whole: Whole) -> Part? {
//		optics.getAll(whole).last
//	}
//
//	public func tryUpdate(_ whole: inout Whole, _ f: @escaping (inout Part) -> Void) {
//		guard let toUpdate = self.tryGet(whole) else {
//			return
//		}
//
//		optics.updateAll(&whole) { part in
//			guard part == toUpdate else {
//				return
//			}
//
//			f(&part)
//		}
//	}
//}

//public struct At<Optics: ArrayOptic>: OptionalOptic where Optics.Part: Equatable {
//	public typealias Whole = Optics.Whole
//	public typealias Part = Optics.Part
//	
//	public let index: Array.Index
//	public let optics: Optics
//	
//	@inlinable
//	public init(
//		_ index: Array.Index,
//		@ArrayOpticBuilder with build: () -> Optics
//	) {
//		self.index = index
//		self.optics = build()
//		
//	}
//	
//	public func tryGet(_ whole: Whole) -> Part? {
//		let results = optics.getAll(whole)
//		
//		guard results.count > self.index else {
//			return nil
//		}
//		
//		return results[self.index]
//	}
//	
//	public func tryUpdate(_ whole: inout Whole, _ f: @escaping (inout Part) -> Void) {
//		guard let toUpdate = self.tryGet(whole) else {
//			return
//		}
//		
//		optics.updateAll(&whole) { part in
//			guard part == toUpdate else {
//				return
//			}
//			
//			f(&part)
//		}
//	}
//}

//public struct Reversed<Optics: ArrayOptic>: ArrayOptic {
//	public typealias Whole = Optics.Whole
//	public typealias Part = Optics.Part
//
//	public let optics: Optics
//
//	@inlinable
//	public init(
//		@ArrayOpticBuilder with build: () -> Optics
//	) {
//		self.optics = build()
//
//	}
//
//	public func getAll(_ whole: Whole) -> [Part] {
//		optics.getAll(whole).reversed()
//	}
//	
//	public func updateAll(_ whole: inout Whole, _ f: @escaping (inout Part) -> Void) {
//		optics.updateAll(&whole, f)
//	}
//}

//public struct Sorted<Optics: ArrayOptic, SortPropertyOptic: Lens>: ArrayOptic
//where Optics.Part == SortPropertyOptic.Whole, SortPropertyOptic.Part: Comparable {
//	public typealias Whole = Optics.Whole
//	public typealias Part = Optics.Part
//	
//	public let reversed: Bool
//	public let optics: Optics
//	public let by: SortPropertyOptic
//	
//	@inlinable
//	public init(
//		reversed: Bool = false,
//		@ArrayOpticBuilder with build: () -> Optics,
//		@LensBuilder by: () -> SortPropertyOptic
//	) {
//		self.reversed = reversed
//		self.optics = build()
//		self.by = by()
//	}
//	
//	public func getAll(_ whole: Whole) -> [Part] {
//		optics.getAll(whole).sorted { left, right in
//			let result = self.by.get(left) < self.by.get(right)
//			return self.reversed ? !result : result
//		}
//	}
//	
//	public func updateAll(_ whole: inout Whole, _ f: @escaping (inout Part) -> Void) {
//		optics.updateAll(&whole, f)
//	}
//}

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

//extension ArrayOptic where Part: Equatable {
////	public var first: some OptionalOptic<Whole, Part> {
////		First {
////			self
////		}
////	}
//
//	public var last: some OptionalOptic<Whole, Part> {
//		Last {
//			self
//		}
//	}
//
//	public func at(_ index: Array.Index) -> some OptionalOptic<Whole, Part> {
//		At(index) {
//			self
//		}
//	}
//
//	public var reversed: some ArrayOptic<Whole, Part> {
//		Reversed {
//			self
//		}
//	}
//}

//public struct Max<Optics: ArrayOptic, PropertyOptic: Lens>: OptionalOptic
//where Optics.Part: Equatable, PropertyOptic.Part: Comparable, Optics.Part == PropertyOptic.Whole {
//	public typealias Whole = Optics.Whole
//	public typealias Part = Optics.Part
//
//	public let optics: Optics
//	public let by: PropertyOptic
//
//	@inlinable
//	public init(
//		@ArrayOpticBuilder with build: () -> Optics,
//		@LensBuilder by: () -> PropertyOptic
//	) {
//		self.optics = build()
//		self.by = by()
//	}
//
//	public func tryGet(_ whole: Whole) -> Part? {
//		optics.getAll(whole).max { left, right in
//			self.by.get(left) < self.by.get(right)
//		}
//	}
//
//	public func tryUpdate(_ whole: inout Whole, _ f: @escaping (inout Part) -> Void) {
//		guard let toUpdate = self.tryGet(whole) else {
//			return
//		}
//
//		optics.updateAll(&whole) { part in
//			guard part == toUpdate else {
//				return
//			}
//
//			f(&part)
//		}
//	}
//}
//
//public struct Min<Optics: ArrayOptic, PropertyOptic: Lens>: OptionalOptic
//where Optics.Part: Equatable, PropertyOptic.Part: Comparable, Optics.Part == PropertyOptic.Whole {
//	public typealias Whole = Optics.Whole
//	public typealias Part = Optics.Part
//
//	public let optics: Optics
//	public let by: PropertyOptic
//
//	@inlinable
//	public init(
//		@ArrayOpticBuilder with build: () -> Optics,
//		@LensBuilder by: () -> PropertyOptic
//	) {
//		self.optics = build()
//		self.by = by()
//	}
//
//	public func tryGet(_ whole: Whole) -> Part? {
//		optics.getAll(whole).min { left, right in
//			self.by.get(left) < self.by.get(right)
//		}
//	}
//
//	public func tryUpdate(_ whole: inout Whole, _ f: @escaping (inout Part) -> Void) {
//		guard let toUpdate = self.tryGet(whole) else {
//			return
//		}
//
//		optics.updateAll(&whole) { part in
//			guard part == toUpdate else {
//				return
//			}
//
//			f(&part)
//		}
//	}
//}
