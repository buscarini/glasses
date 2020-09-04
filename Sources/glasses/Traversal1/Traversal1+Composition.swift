//
//  Traversal1+Composition.swift
//  glasses-iOS
//
//  Created by José Manuel Sánchez Peñarroja on 25/04/2020.
//  Copyright © 2020 glasses. All rights reserved.
//

import Foundation

public extension Traversal1 {
	func compose<C, D>(
		_ right: Traversal1<A, C, D, B>
	) -> Traversal1<S, C, D, T> {
		glasses.compose(self, right)
	}
}


public func compose<S, A, B, T, C, D>(
	_ left: Traversal1<S, A, B, T>,
	_ right: Traversal1<A, C, D, B>
) -> Traversal1<S, C, D, T> {
	.init(
		get: { s in
			left._get(s).flatMap(right._get)
		},
		update: { cd in
			{ s in
				guard
					let a = left._get(s),
					let b = right._update(cd)(a)
				else {
					return nil
				}
				
				return left.set(s, value: b)
			}
		}
	)
}

public func <<< <S, A, B, T, C, D> (
	_ left: Traversal1<S, A, B, T>,
	_ right: Traversal1<A, C, D, B>
) -> Traversal1<S, C, D, T> {
	compose(left, right)
}

public func >>> <S, A, B, T, C, D> (
	_ left: Traversal1<A, C, D, B>,
	_ right: Traversal1<S, A, B, T>
) -> Traversal1<S, C, D, T> {
	compose(right, left)
}
