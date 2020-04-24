//
//  Monoid+Boolean.swift
//  TYRSharedUtils
//
//  Created by José Manuel Sánchez Peñarroja on 05/12/2018.
//  Copyright © 2018 Tyris. All rights reserved.
//

import Foundation

public extension Monoid where T == Bool {
	static var any: Monoid<Bool> {
		.init(empty: false, combine: { $0 || $1 })
	}
	
	static var all: Monoid<Bool> {
		.init(empty: true, combine: { $0 && $1 })
	}
}
