import Foundation

public struct Sorted<L: LensOptic, SortPropertyOptic: LensOptic, Element>: LensOptic
where L.Part == [Element], SortPropertyOptic.Whole == Element, SortPropertyOptic.Part: Comparable {
	public typealias Whole = L.Whole
	public typealias Part = L.Part
	
	public let reversed: Bool
	public let lens: L
	public let by: SortPropertyOptic
	
	@inlinable
	public init(
		reversed: Bool = false,
		@ConcatLensesBuilder with build: () -> L,
		@LensBuilder by: () -> SortPropertyOptic
	) {
		self.reversed = reversed
		self.lens = build()
		self.by = by()
	}
	
	public func get(_ whole: Whole) -> Part {
		lens.get(whole).sorted { left, right in
			let result = self.by.get(left) < self.by.get(right)
			return self.reversed ? !result : result
		}
	}
	
	public func update(_ whole: inout Whole, _ f: @escaping (inout Part) -> Void) {
		lens.update(&whole) { elements in
			elements.updateInPlace(update: f) { indexed in
				indexed = indexed.sorted { left, right in
					let result = self.by.get(left.1) < self.by.get(right.1)
					return self.reversed ? !result : result
				}
			}
		}
	}
}
