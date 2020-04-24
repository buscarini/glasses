//
//  Either+Traversal.swift
//  glasses-iOS Tests
//
//  Created by José Manuel Sánchez Peñarroja on 24/04/2020.
//  Copyright © 2020 glasses. All rights reserved.
//

import Foundation

public extension Either where A == B {
	func each<C>() -> Traversal<Either<A, A>, A, C, Either<C, C>> {
		.init(
			get: { s in
				s.fold(
					{[$0]},
					{[$0]}
				)
			},
			update: { f in
				{ s in
					s.bimap(f, f)
				}
			}
		)
	}
}
