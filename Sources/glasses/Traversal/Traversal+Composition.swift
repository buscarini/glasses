//
//  Traversal+Composition.swift
//  glasses
//
//  Created by José Manuel Sánchez Peñarroja on 25/10/17.
//

import Foundation

public func compose<S, A, B, T, C, D>(
	_ left: Traversal<S, A, B, T>,
	_ right: Traversal<A, C, D, B>
) -> Traversal<S, C, D, T> {
	Traversal(get: { s in
		left._get(s).flatMap { a in
			right._get(a)
		}
	}, update: { (f: @escaping ((C) -> D)) -> (S) -> T in
		{ (s: S) in
			left._update { (a: A) -> B in
				right._update(f)(a)
			}(s)
		}
	})
}

public func <<< <S, A, B, T, C, D> (_ left: Traversal<S, A, B, T>, _ right: Traversal<A, C, D, B>) -> Traversal<S, C, D, T> {
	compose(left, right)
}

public func >>> <S, A, B, T, C, D> (_ left: Traversal<A, C, D, B>, _ right: Traversal<S, A, B, T>) -> Traversal<S, C, D, T> {
	compose(right, left)
}

