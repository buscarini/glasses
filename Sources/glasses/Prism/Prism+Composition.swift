//
//  Prism+Composition.swift
//  glasses
//
//  Created by José Manuel Sánchez Peñarroja on 26/10/17.
//

import Foundation

public extension Prism {
	func compose<C, D>(
		_ right: Prism<A, C, D, B>
	) -> Prism<S, C, D, T> {
		glasses.compose(self, right)
	}
}


public func compose<S, A, B, T, C, D>(
	_ left: Prism<S, A, B, T>,
	_ right: Prism<A, C, D, B>
) -> Prism<S, C, D, T> {
	.init(
		embed: { d in
			left._embed(right._embed(d))
	},
		extract: { s in
			left._extract(s).flatMap(right._extract)
	}
	)
}

public func <<< <S, A, B, T, C, D> (
	_ left: Prism<S, A, B, T>,
	_ right: Prism<A, C, D, B>
) -> Prism<S, C, D, T> {
	compose(left, right)
}

public func >>> <S, A, B, T, C, D> (
	_ left: Prism<A, C, D, B>,
	_ right: Prism<S, A, B, T>
) -> Prism<S, C, D, T> {
	compose(right, left)
}
