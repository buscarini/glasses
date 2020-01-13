//
//  Lens+Composition.swift
//  glasses
//
//  Created by José Manuel Sánchez Peñarroja on 25/10/17.
//

import Foundation


public func compose<S, A, B, T, C, D>(
	_ left: Lens<S, A, B, T>,
	_ right: Lens<A, C, D, B>
) -> Lens<S, C, D, T> {
	Lens<S, C, D, T>(
		get: { (s: S) -> C in
			right._get(left._get(s))
		},
		update: { (cd: @escaping ((C) -> D)) -> (S) -> T in
			{ (s: S) -> T in
				s
					|> left._update { a in
						right._update(cd)(a)
				}
			}
		}
	)
}

public func <<< <S, A, B, T, C, D> (_ left: Lens<S, A, B, T>, _ right: Lens<A, C, D, B>) -> Lens<S, C, D, T> {
	return compose(left, right)
}

public func <<< <S, A, C> (_ left: WritableKeyPath<S, A>, _ right: Lens<A, C, C, A>) -> Lens<S, C, C, S> {

	return left.lens <<< right
}

public func <<< <S, A, C> (_ left: Lens<S, A, A, S>, _ right: WritableKeyPath<A, C>) -> Lens<S, C, C, S> {
	return left <<< right.lens
}


public func >>> <S, A, B, T, C, D> (_ left: Lens<A, C, D, B>, _ right: Lens<S, A, B, T>) -> Lens<S, C, D, T> {
	return compose(right, left)
}
