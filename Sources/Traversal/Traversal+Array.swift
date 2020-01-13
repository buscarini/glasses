//
//  Traversal+Array.swift
//  glasses
//
//  Created by José Manuel Sánchez Peñarroja on 17/11/17.
//

import Foundation

public func _map<A, B>() -> Traversal<[A], A, B, [B]> {
	return Traversal(get: { (s: [A]) in
		return s
	}, update: { (f: @escaping ((A) -> B)) -> ([A]) -> [B] in
		{ s in
			return s.map(f)
		}
	})
}

public func _where<A>(_ f: @escaping (A) -> Bool) -> Traversal<[A], A, A, [A]> {
	return Traversal(get: { (s: [A]) in
		return s.filter(f)
	}, update: { g in
		{ s in
			return s.map {
				return f($0) ? g($0) : $0
			}
		}
	})
}

public func _where<A, P: Equatable>(_ keyPath: KeyPath<A, P>, equals value: P) -> Traversal<[A], A, A, [A]> {
	return Traversal(get: { (s: [A]) -> [A] in
		return s.filter { $0[keyPath: keyPath] == value }
	}, update: { (f: @escaping ((A) -> A)) -> ([A]) -> [A] in
		{ s in
			return s.map { item in
				guard item[keyPath: keyPath] == value else {
					return item
				}
				
				return f(item)
			}
		}
	})
}

