//
//  Prism+Composition.swift
//  glasses
//
//  Created by José Manuel Sánchez Peñarroja on 26/10/17.
//

import Foundation


public func compose<S, A, B, T, C, D>(_ left: Prism<S, A, B, T>, _ right: Prism<A, C, D, B>) -> Prism<S, C, D, T> {
	return Prism(get: { s in
		return left._get(s).flatMap { a in
			return right._get(a)
		}
	}, update: { (f: @escaping ((C) -> D)) -> (S) -> T in
		{ (s: S) in
			return left._update { (a: A) -> B in
				return right._update(f)(a)
			}(s)
		}
	})
}

public func <<< <S, A, B, T, C, D> (_ left: Prism<S, A, B, T>, _ right: Prism<A, C, D, B>) -> Prism<S, C, D, T> {
	return compose(left, right)
}

public func >>> <S, A, B, T, C, D> (_ left: Prism<A, C, D, B>, _ right: Prism<S, A, B, T>) -> Prism<S, C, D, T> {
	return compose(right, left)
}
