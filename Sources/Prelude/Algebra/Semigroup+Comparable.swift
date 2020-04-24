//
//  Semigroup+Comparable.swift
//  glasses-iOS
//
//  Created by José Manuel Sánchez Peñarroja on 25/04/2020.
//  Copyright © 2020 glasses. All rights reserved.
//

import Foundation

public extension Semigroup where T: Comparable {
	static var min: Semigroup {
		.init(
			combine: { left, right in
				left < right ? left : right
		})
	}
	
	static var max: Semigroup {
		.init(
			combine: { left, right in
				left < right ? right : left
		})
	}
}
