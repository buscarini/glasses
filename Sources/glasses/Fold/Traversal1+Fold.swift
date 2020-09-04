//
//  Traversal1+Fold.swift
//  glasses-iOS
//
//  Created by José Manuel Sánchez Peñarroja on 26/04/2020.
//  Copyright © 2020 glasses. All rights reserved.
//

import Foundation

public extension Traversal1 {
	func fold() -> Fold<S, A> {
		.init(get: { s in
			[
				self.get(s)
			]
			.compactMap { $0 }
		})
	}
}
