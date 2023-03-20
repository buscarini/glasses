import Foundation

public struct Enumerated<L: LensOptic, Element>: LensOptic
where L.Part == [Element] {
	public typealias Whole = L.Whole
	public typealias Part = [(Array.Index, Element)]
	
	public let lens: EnumeratedLens<L, Element>
	
	@inlinable
	public init(
		@LensBuilder with build: () -> L
	) {
		self.lens = EnumeratedLens(lens: build())
	}
	
	public func get(_ whole: L.Whole) -> Part {
		lens.get(whole)
	}
	
	public func update(_ whole: inout L.Whole, _ f: @escaping (inout Part) -> Void) {
		lens.update(&whole, f)
	}
}



public struct EnumeratedLens<L: LensOptic, Element>: LensOptic
where L.Part == [Element] {
	public typealias Whole = L.Whole
	public typealias Part = [(Array.Index, Element)]
	
	public let lens: L
	
	public init(lens: L) {
		self.lens = lens
	}
	
	public func get(_ whole: L.Whole) -> [(Array.Index, Element)] {
		lens.get(whole).enumerated().map { ($0.offset, $0.element) }
	}
	
	public func update(_ whole: inout L.Whole, _ f: @escaping (inout [(Array.Index, Element)]) -> Void) {
		lens.update(&whole) { array in
			var enumerated = array.enumerated().map { ($0.offset, $0.element) }
			f(&enumerated)
			array = enumerated.map { $0.1 }
		}
	}
}
