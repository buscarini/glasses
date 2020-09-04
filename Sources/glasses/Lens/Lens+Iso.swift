//
//  Lens+Iso.swift
//  glasses-iOS
//
//  Created by José Manuel Sánchez Peñarroja on 13/01/2020.
//  Copyright © 2020 glasses. All rights reserved.
//

import Foundation

public func compose<S, A>(
	_ left: Lens<S, A, A, S>,
	_ right: Iso<A, A>) -> Lens<S, A, A, S> {
	Lens<S, A, A, S>(
		get: { s in
			right._from(left._get(s))
		},
		update: { f in
			{ s in
				s
				|> left._update { a in
					f(right._to(a))
				}
		}
	})
}
