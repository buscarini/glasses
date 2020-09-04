//
//  Lens+Traversal1.swift
//  glasses-iOS
//
//  Created by José Manuel Sánchez Peñarroja on 25/04/2020.
//  Copyright © 2020 glasses. All rights reserved.
//

import Foundation

public extension Lens {
	func traversal1() -> Traversal1<S, A, B, T> {
		Traversal1<S, A, B, T>.init(
			get: { s in
				A?.some(self._get(s))
			},
			update: { f in
				{ s in
					self.update(f, s)
				}
			}
		)
	}
}
