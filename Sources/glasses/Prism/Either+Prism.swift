//
//  Prism+Either.swift
//  glasses-iOS
//
//  Created by José Manuel Sánchez Peñarroja on 25/04/2020.
//  Copyright © 2020 glasses. All rights reserved.
//

import Foundation

public extension Either {
	static func _left<C>() -> Prism<Either<A, B>, A, C, Either<C, B>> {
		.init(
			embed: { c in
				Either<C, B>.left(c)
			},
			extract: { s in
				s.left
			}
		)
	}
	
	static func _right<C>() -> Prism<Either<A, B>, B, C, Either<A, C>> {
		.init(
			embed: { c in
				Either<A, C>.right(c)
			},
			extract: { s in
				s.right
			}
		)
	}
}
