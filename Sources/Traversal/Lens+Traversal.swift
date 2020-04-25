//
//  Lens+Traversal.swift
//  glasses
//
//  Created by José Manuel Sánchez Peñarroja on 25/10/17.
//

import Foundation

public extension Lens {
	func traversal() -> Traversal<S, A, B, T> {
		.init(
			get: { s in
				[self._get(s)]
			},
			update: { f in
				{ s in
					self._update(f)(s)
				}
			}
		)
	}
}


public func <<< <S, A, B, T> (_ left: (Lens<S, A, B, T>) -> Traversal<[S], A, B, [T]>, _ right: Lens<S, A, B, T>) -> Traversal<[S], A, B, [T]> {
	return left(right)
}


public func compose<S, A, B, T, C, D>(_ left: Lens<S, A, B, T>, _ right: Traversal<A, C, D, B>) -> Traversal<S, C, D, T> {
	return Traversal(get: { s in
		return right._get(left._get(s))
	}, update: { (f: @escaping ((C) -> D)) -> (S) -> T in
		{ (s: S) in
			return left._update { a in
				return right._update(f)(a)
			}(s)
		}
	})
}

public func <<< <S, A, B, T, C, D>(_ left: Lens<S, A, B, T>, _ right: Traversal<A, C, D, B>) -> Traversal<S, C, D, T> {
	return compose(left, right)
}

public func <<< <S, A, C>(_ left: WritableKeyPath<S, A>, _ right: Traversal<A, C, C, A>) -> Traversal<S, C, C, S> {
	return compose(left.lens, right)
}

public func compose <S, A, B, C, D, T>(_ left: Traversal<S, A, B, T>, _ right: Lens<A, C, D, B>) -> Traversal<S, C, D, T> {
	return Traversal(get: { s in
		let aa = left._get(s)
		return aa.map(right._get)
	}, update: { (f: @escaping ((C) -> D)) -> (S) -> T in
		{ (s: S) in
			return left._update { a in
				return right._update(f)(a)
			}(s)
		}
	})
}

public func <<< <S, A, B, C, D, T>(_ left: Traversal<S, A, B, T>, _ right: Lens<A, C, D, B>) -> Traversal<S, C, D, T> {
	return compose(left, right)
}

public func <<< <S, A, B>(_ left: SimpleTraversal<S, A>, _ right: WritableKeyPath<A, B>) -> SimpleTraversal<S, B> {
	return compose(left, right.lens)
}

