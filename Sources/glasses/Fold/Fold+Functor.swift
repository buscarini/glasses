//
//  Fold+Functor.swift
//  glasses-iOS
//
//  Created by José Manuel Sánchez Peñarroja on 25/04/2020.
//  Copyright © 2020 glasses. All rights reserved.
//

import Foundation

public extension Fold {
	func map<B>(
		_ f: @escaping (A) -> B
	) -> Fold<S, B> {
		.init(get: { s in
			self._get(s).map(f)
		})
	}
}
