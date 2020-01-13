//
//  Prism+Traversal.swift
//  glasses
//
//  Created by José Manuel Sánchez Peñarroja on 22/11/17.
//

import Foundation


public func <<< <S, A, B, T> (_ left: (Prism<S, A, B, T>) -> Traversal<[S], A, B, [T]>, _ right: Prism<S, A, B, T>) -> Traversal<[S], A, B, [T]> {
	return left(right)
}

public func compose<S, A, B, T, C, D>(_ left: Prism<S, A, B, T>, _ right: Traversal<A, C, D, B>) -> Traversal<S, C, D, T> {
	return Traversal(get: { s in
		guard let a = left._get(s) else { return [] }
		return right._get(a)
	}, update: { (f: @escaping ((C) -> D)) -> (S) -> T in
		{ (s: S) in
			return left._update { a in
				return right._update(f)(a)
			}(s)
		}
	})
}

public func <<< <S, A, B, T, C, D>(_ left: Prism<S, A, B, T>, _ right: Traversal<A, C, D, B>) -> Traversal<S, C, D, T> {
	return compose(left, right)
}


public func compose <S, A, B, T, C, D>(_ left: Traversal<S, A, B, T>, _ right: Prism<A, C, D, B>) -> Traversal<S, C, D, T> {
	return Traversal(get: { s in
		return left.get(s).compactMap { right._get($0) }
	}, update: { (f: @escaping ((C) -> D)) -> (S) -> T in
		{ (s: S) in
			return left._update { a in
				return right._update(f)(a)
			}(s)
		}
	})
}

public func <<< <S, A, B, T, C, D>(_ left: Traversal<S, A, B, T>, _ right: Prism<A, C, D, B>) -> Traversal<S, C, D, T> {
	return compose(left, right)
}

