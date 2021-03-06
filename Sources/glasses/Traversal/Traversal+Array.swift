//
//  Traversal+Array.swift
//  glasses
//
//  Created by José Manuel Sánchez Peñarroja on 17/11/17.
//

import Foundation

public extension Traversal {
	func prefix<Element>(
		_ prefix: Int
	) -> Traversal where S == T, S == [Element] {
		.init(get: { s in
			Array(self._get(s).prefix(prefix))
		}, update: { f in
			{ rr in
				let first = rr.prefix(prefix)
				let rest = rr.dropFirst(prefix)
				let firstMapped = self._update(f)(Array(first))

				return S(firstMapped + rest)
			}
		})
	}
}

public func each<A, B>() -> Traversal<[A], A, B, [B]> {
	Traversal<[A], A, B, [B]>(get: { (s: [A]) in
		s
	}, update: { (f: @escaping ((A) -> B)) -> ([A]) -> [B] in
		{ (s: [A]) -> [B] in
			s.map(f)
		}
	})
}

public func filter<A>(
	_ pred: @escaping (A) -> Bool
) -> Traversal<[A], A, A, [A]> {
	Traversal<[A], A, A, [A]>(
		get: { (s: [A]) -> [A] in
			s.filter(pred)
		},
		update: { (f: @escaping ((A) -> A)) -> ([A]) -> [A] in
			{ (s: [A]) -> [A] in
				s.map {
					pred($0) ? f($0) : $0
				}
			}
		}
	)
}

//public func _where<A, P: Equatable>(_ keyPath: KeyPath<A, P>, equals value: P) -> Traversal<[A], A, A, [A]> {
//	Traversal(get: { (s: [A]) -> [A] in
//		s.filter { $0[keyPath: keyPath] == value }
//	}, update: { (f: @escaping ((A) -> A)) -> ([A]) -> A in
//		{ s in
//			s.map { item in
//				guard item[keyPath: keyPath] == value else {
//					return item
//				}
//
//				return f(item)
//			}
//		}
//	})
//}

public func taking<A>(
	_ prefix: Int
) -> (Traversal<[A], A, A, [A]>) -> Traversal<[A], A, A, [A]> {
	{ t in
		.init(get: { s in
			Array(t._get(s).prefix(prefix))
		}, update: { f in
			{ aa in
				let first = aa.prefix(prefix)
				let rest = aa.dropFirst(prefix)
				let firstMapped = t._update(f)(Array(first))
				return Array(firstMapped + rest)
			}
		})
	}
}

public func prefix<A>(
	_ prefix: Int
) -> Traversal<[A], A, A, [A]> {
	.init(
		get: { aa in
			Array(aa.prefix(prefix))
		},
		update: { f in
			{ aa in
				let first = aa.prefix(prefix)
				let rest = aa.dropFirst(prefix)
				return Array(first.map(f) + rest)
			}
		}
	)
}

public func suffix<A>(
	_ suffix: Int
) -> Traversal<[A], A, A, [A]> {
	.init(
		get: { aa in
			Array(aa.suffix(suffix))
		},
		update: { f in
			{ aa in
				let first = aa.dropLast(suffix)
				let rest = aa.suffix(suffix)
				return Array(first + rest.map(f))
			}
		}
	)
}
