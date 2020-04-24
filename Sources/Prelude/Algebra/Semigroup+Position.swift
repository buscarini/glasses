//
//  Semigroup+Position.swift
//  TYRSharedUtils
//
//  Created by José Manuel Sánchez Peñarroja on 30/03/2020.
//  Copyright © 2020 Tyris. All rights reserved.
//

import Foundation

public extension Semigroup {
	static var first: Semigroup {
		.init(combine: { left, _ in left })
	}
	
	static var last: Semigroup {
		.init(combine: { _, right in right })
	}
}
