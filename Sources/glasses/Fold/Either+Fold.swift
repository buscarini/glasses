//
//  Either+Fold.swift
//  glasses-iOS
//
//  Created by José Manuel Sánchez Peñarroja on 25/04/2020.
//  Copyright © 2020 glasses. All rights reserved.
//

import Foundation

public extension Either where A == B {
	static func fold() -> Fold<Either<A, A>, A> {
		.init(
			get: { s in
				s.fold(
					{[$0]},
					{[$0]}
				)
			}
		)
	}
}
