//
//  Array+Prism.swift
//  glasses
//
//  Created by José Manuel Sánchez Peñarroja on 26/10/17.
//

import Foundation

public extension Array {
	static func _first() -> Traversal1<[Element], Element, Element, [Element]> {
		.init(
			get: { aa in
				aa.first
			},
			update: { f in
				{ s in
					guard s.count > 0 else { return s }

					var result = s
					result[0] = f(result[0])
					return result
				}
			}
		)
	}
	
	static func _index(_ index: Int) -> Traversal1<[Element], Element, Element, [Element]> {
		.init(
			get: { s in
				guard s.count > index else { return nil }
				return s[index]
			},
			update: { f in
				{ s in
					guard s.count > index else { return s }
					
					var result = s
					result[index] = f(result[index])
					return result
				}
			}
		)
	}
	
	static func _last() -> Traversal1<[Element], Element, Element, [Element]> {
		.init(
			get: { aa in
				aa.last
			},
			update: { f in
				{ s in
					guard let last = s.last else { return s }

					return s.dropLast() + [ f(last) ]
				}
			}
		)
	}

	static func _first<A>(
		where pred: @escaping (A) -> Bool
	) -> Traversal1<[A], A, A, [A]> {
		.init(
			get: { s in
				s.first(where: pred)
			},
			update: { f in
				{ s in
					var result: [A] = []
					var firstTime = true
					for a in s {
						let matches = pred(a)
						result.append(matches && firstTime ? f(a) : a)
						if matches { firstTime = false }
					}
					
					return result
				}
			}
		)
	}
	
	static func _first<A, P: Equatable>(
		where keyPath: KeyPath<A, P>,
		equals value: P
	) -> Traversal1<[A], A, A, [A]> {
		_first(where: { a in
			a[keyPath: keyPath] == value
		})
	}
	
	static func _last<A>(
		where pred: @escaping (A) -> Bool
	) -> Traversal1<[A], A, A, [A]> {
		.init(
			get: { s in
				s.filter(pred).last
			},
			update: { f in
				{ s in
					var result: [A] = []
					var firstTime = true
					for a in s.reversed() {
						let matches = pred(a)
						result.append(matches && firstTime ? f(a) : a)
						if matches { firstTime = false }
					}
					
					return result.reversed()
				}
			}
		)
	}

	static func _last<A, P: Equatable>(
		where keyPath: KeyPath<A, P>,
		equals value: P
	) -> Traversal1<[A], A, A, [A]> {
		_last(where: { a in
			a[keyPath: keyPath] == value
		})
	}
}

public func first<Element>() -> Traversal1<[Element], Element, Element, [Element]> {
	[Element]._first()
}

public func index<Element>(_ index: Int) -> Traversal1<[Element], Element, Element, [Element]> {
	[Element]._index(index)
}

public func last<Element>() -> Traversal1<[Element], Element, Element, [Element]> {
	[Element]._last()
}

public func first<A>(
	where pred: @escaping (A) -> Bool
) -> Traversal1<[A], A, A, [A]> {
	[A]._first(where: pred)
}

public func last<A>(
	where pred: @escaping (A) -> Bool
) -> Traversal1<[A], A, A, [A]> {
	[A]._last(where: pred)
}
