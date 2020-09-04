//
//  Fold+Composition.swift
//  glasses-iOS Tests
//
//  Created by José Manuel Sánchez Peñarroja on 25/04/2020.
//  Copyright © 2020 glasses. All rights reserved.
//

import Foundation

public extension Fold {
	func compose<B>(
		_ right: Fold<A, B>
	) -> Fold<S, B> {
		glasses.compose(self, right)
	}
}

public func compose<S, A, B>(
	_ left: Fold<S, A>,
	_ right: Fold<A, B>
) -> Fold<S, B> {
	.init(get: { s in
		left._get(s).flatMap(right._get)
	})
}

public func <<< <S, A, B> (
	_ left: Fold<S, A>,
	_ right: Fold<A, B>
) -> Fold<S, B> {
	compose(left, right)
}

public func >>> <S, A, B> (
	_ left: Fold<A, B>,
	_ right: Fold<S, A>
) -> Fold<S, B> {
	compose(right, left)
}

