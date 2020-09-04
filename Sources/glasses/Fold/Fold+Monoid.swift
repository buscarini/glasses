//
//  Fold+Monoid.swift
//  glasses-iOS
//
//  Created by José Manuel Sánchez Peñarroja on 25/04/2020.
//  Copyright © 2020 glasses. All rights reserved.
//

import Foundation
import Algebraic

public extension Fold {
	func reduced(
		_ m: Monoid<A>,
		_ s: S
	) -> A {
		self._get(s).reduced(m)
	}
}
