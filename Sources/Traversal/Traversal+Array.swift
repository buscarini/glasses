//
//  Traversal+Array.swift
//  glasses
//
//  Created by José Manuel Sánchez Peñarroja on 17/11/17.
//

import Foundation

public func _map<A, B>() -> Traversal<[A], A, B, [B]> {
	Traversal(get: { (s: [A]) in
		s
	}, update: { (f: @escaping ((A) -> B)) -> ([A]) -> [B] in
		{ s in
			return s.map(f)
		}
	})
}

public func _where<A>(_ f: @escaping (A) -> Bool) -> Traversal<[A], A, A, [A]> {
	Traversal(get: { (s: [A]) in
		s.filter(f)
	}, update: { g in
		{ s in
			return s.map {
				return f($0) ? g($0) : $0
			}
		}
	})
}

public func _where<A, P: Equatable>(_ keyPath: KeyPath<A, P>, equals value: P) -> Traversal<[A], A, A, [A]> {
	Traversal(get: { (s: [A]) -> [A] in
		s.filter { $0[keyPath: keyPath] == value }
	}, update: { (f: @escaping ((A) -> A)) -> ([A]) -> [A] in
		{ s in
			s.map { item in
				guard item[keyPath: keyPath] == value else {
					return item
				}
				
				return f(item)
			}
		}
	})
}
//
//public func taking<A>(_ prefix: Int) -> Traversal<[A], A, A, [A]> { {
//	Traversal<[A], A, A, [A]>(
//		get: { s in
//
//		})
//		{ update in
//			{ s in
//
//			}
//		}
//}
