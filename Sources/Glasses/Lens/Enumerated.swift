import Foundation

public struct Enumerated<L: LensOptic, Element, NewElement>: LensOptic
where L.Part == [Element], L.NewPart == [NewElement] {
	public typealias Whole = L.Whole
	public typealias NewWhole = L.NewWhole
	public typealias Part = [(Array.Index, Element)]
	public typealias NewPart = [(Array.Index, NewElement)]
	
	public let lens: EnumeratedLens<L, Element, NewElement>
	
	@inlinable
	public init(
		@LensBuilder with build: () -> L
	) {
		self.lens = EnumeratedLens(lens: build())
	}
	
	public func get(_ whole: Whole) -> Part {
		lens.get(whole)
	}
	
	public func update(_ whole: Whole, _ f: @escaping (Part) -> NewPart) -> NewWhole {
		lens.update(whole, f)
	}
}



public struct EnumeratedLens<L: LensOptic, Element, NewElement>: LensOptic
where L.Part == [Element], L.NewPart == [NewElement] {
	public typealias Whole = L.Whole
	public typealias NewWhole = L.NewWhole
	public typealias Part = [(Array.Index, Element)]
	public typealias NewPart = [(Array.Index, NewElement)]
	
	public let lens: L
	
	public init(lens: L) {
		self.lens = lens
	}
	
	public func get(_ whole: L.Whole) -> [(Array.Index, Element)] {
		lens.get(whole).enumerated().map { ($0.offset, $0.element) }
	}
	
	public func update(_ whole: L.Whole, _ f: @escaping ([(Array.Index, Element)]) -> [(Array.Index, NewElement)]) -> L.NewWhole {
		lens.update(whole) { array in
			f(
				array.enumerated().map { ($0.offset, $0.element) }
			).map {$0.1 }
		}
	}
}
