//
//  Lens+Fold.swift
//  glasses-iOS Tests
//
//  Created by José Manuel Sánchez Peñarroja on 25/04/2020.
//  Copyright © 2020 glasses. All rights reserved.
//

import Foundation

public extension Lens {
	func fold() -> Fold<S, A> {
		.init(get: { s in
			[self._get(s)]
		})
	}
}
