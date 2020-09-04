//
//  Prism+Traversal.swift
//  glasses
//
//  Created by José Manuel Sánchez Peñarroja on 22/11/17.
//

import Foundation

public extension Prism {
	func traversal1() -> Traversal1<S, A, B, T> {
		.init(
			get: { s in
				self._extract(s)
			},
			update: { f in
				{ s in
					self._extract(s)
						.map(f)
						.flatMap(self._embed)
				}
			}
		)
	}
}
