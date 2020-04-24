//
//  Fold+Semigroup.swift
//  glasses-iOS
//
//  Created by José Manuel Sánchez Peñarroja on 25/04/2020.
//  Copyright © 2020 glasses. All rights reserved.
//

import Foundation

public extension Fold {
	func reduced(
		_ sem: Semigroup<A>,
		_ s: S
	) -> A? {
		self._get(s).reduced(sem)
	}
}
