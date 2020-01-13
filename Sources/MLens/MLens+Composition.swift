//
//  MLens+Composition.swift
//  glasses
//
//  Created by José Manuel Sánchez Peñarroja on 29/6/18.
//

import Foundation

public func compose<S, A, B>(_ left: MLens<S, A>, _ right: MLens<A, B>) -> MLens<S, B> {
	return MLens<S, B>(get: { (s: S) -> B in
		return right._get(left._get(s))
	}, update: { f in
		{ s in
			left._update { a in
				right._update(f)(&a)
			}(&s)
		}
	})
}

public func <<< <S, A, B> (_ left: MLens<S, A>, _ right: MLens<A, B>) -> MLens<S, B> {
	return compose(left, right)
}

public func <<< <S, A, B> (_ left: WritableKeyPath<S, A>, _ right: MLens<A, B>) -> MLens<S, B> {

	return left.mlens <<< right
}

public func <<< <S, A, B> (_ left: MLens<S, A>, _ right: WritableKeyPath<A, B>) -> MLens<S, B> {
	return left <<< right.mlens
}


public func >>> <S, A, B> (_ left: MLens<A, B>, _ right: MLens<S, A>) -> MLens<S, B> {
	return compose(right, left)
}

