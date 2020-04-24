//
//  Iso+Composition.swift
//  glasses-iOS
//
//  Created by José Manuel Sánchez Peñarroja on 13/01/2020.
//  Copyright © 2020 glasses. All rights reserved.
//

import Foundation

public extension Iso {
	func compose<B>(
		_ right: Iso<A, B>
	) -> Iso<S, B> {
		glasses.compose(self, right)
	}
}

public func compose<S, A, B>(
	_ left: Iso<S, A>,
	_ right: Iso<A, B>
) -> Iso<S, B> {
	Iso<S, B>(
		from: { b in
			left._from(right._from(b))
		}) { s in
			right._to(left._to(s))
		}
}

public func <<< <S, A, B> (
	_ left: Iso<S, A>,
	_ right: Iso<A, B>
) -> Iso<S, B> {
	compose(left, right)
}

public func >>> <S, A, B> (
	_ left: Iso<A, B>,
	_ right: Iso<S, A>
) -> Iso<S, B> {
	compose(right, left)
}
