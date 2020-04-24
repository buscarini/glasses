//
//  Monoid+Array.swift
//  glasses-iOS
//
//  Created by José Manuel Sánchez Peñarroja on 24/04/2020.
//  Copyright © 2020 glasses. All rights reserved.
//

import Foundation

public extension Monoid {
	static var array: Monoid<[T]> {
		.init(
			empty: [],
			combine: { $0 + $1 }
		)
	}
}
