//
//  Prism+Composition.swift
//  glasses
//
//  Created by José Manuel Sánchez Peñarroja on 26/10/17.
//

import Foundation


public func compose<S, A, B, T, C, D>(_ left: Prism<S, A, B, T>, _ right: Prism<A, C, D, B>) -> Prism<S, C, D, T> {
	Prism(get: { s in
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

public func <<< <S, A, B, T, C, D> (_ left: Prism<S, A, B, T>, _ right: Prism<A, C, D, B>) -> Prism<S, C, D, T> {
	compose(left, right)
}

public func >>> <S, A, B, T, C, D> (_ left: Prism<A, C, D, B>, _ right: Prism<S, A, B, T>) -> Prism<S, C, D, T> {
	compose(right, left)
}
