//
//  Prism+Methods.swift
//  glasses-iOS
//
//  Created by José Manuel Sánchez Peñarroja on 26/04/2020.
//  Copyright © 2020 glasses. All rights reserved.
//

import Foundation

public extension Prism {
	func get(_ s: S) -> A? {
		self._extract(s)
	}
	
	func set(_ s: S, value: B) -> T? {
		self._embed(value)
	}
	
	func update(
		_ f: @escaping (A) -> B, _ s: S
	) -> T? {
		glasses.update(self, f)(s)
	}
}
