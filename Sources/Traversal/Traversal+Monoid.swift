//
//  Traversal+Monoid.swift
//  glasses-iOS
//
//  Created by José Manuel Sánchez Peñarroja on 25/04/2020.
//  Copyright © 2020 glasses. All rights reserved.
//

import Foundation

public extension Traversal {
	func reduced(
		_ s: S,
		_ m: Monoid<A>
	) -> A {
		self._get(s).reduced(m)
	}
}
