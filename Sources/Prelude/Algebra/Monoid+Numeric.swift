//
//  Monoid+Numeric.swift
//  TYRSharedUtils
//
//  Created by José Manuel Sánchez Peñarroja on 21/05/2019.
//  Copyright © 2019 Tyris. All rights reserved.
//

import Foundation

public extension Monoid where T: Numeric {
	static var sum: Monoid<T> {
		.init(empty: 0, combine: { $0 + $1 })
	}
	
	static var product: Monoid<T> {
		.init(empty: 1, combine: { $0 * $1 })
	}
}
