//
//  Lens+Methods.swift
//  glasses-iOS
//
//  Created by José Manuel Sánchez Peñarroja on 25/04/2020.
//  Copyright © 2020 glasses. All rights reserved.
//

import Foundation

public extension Lens {
	func get(_ s: S) -> A {
		self._get(s)
	}
	
	func set(_ s: S, value: B) -> T {
    	let f: (S) -> T = self._update { _ in value }
    	return s |> f
	}
	
	func update(
		_ f: @escaping (A) -> B, _ s: S
	) -> T {
		self._update(f)(s)
	}
}
