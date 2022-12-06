import Foundation

extension Array {
	public mutating func updateInPlace(
		update: @escaping (inout [Element]) -> Void,
		prepare: (inout [(Index, Element)]) -> Void
	) {
		var indexed = zip(self.indices, self).map { $0 }
		prepare(&indexed)
		let indices = indexed.map { $0.0 }

		var toUpdate = indexed.map { $0.1 }
		update(&toUpdate)

		zip(indices, toUpdate).forEach { index, element in
			self[index] = element
		}
	}
}
