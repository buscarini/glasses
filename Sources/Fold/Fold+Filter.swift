//
//  Fold+Filter.swift
//  glasses-iOS
//
//  Created by José Manuel Sánchez Peñarroja on 25/04/2020.
//  Copyright © 2020 glasses. All rights reserved.
//

import Foundation

public extension Fold {
	func filter(
		_ f: @escaping (A) -> Bool
	) -> Fold<S, A> {
		.init(get: { s in
			self._get(s).filter(f)
		})
	}
}
