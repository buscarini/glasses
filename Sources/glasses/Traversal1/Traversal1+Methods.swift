//
//  Traversal1+Method.swift
//  glasses-iOS
//
//  Created by José Manuel Sánchez Peñarroja on 25/04/2020.
//  Copyright © 2020 glasses. All rights reserved.
//

import Foundation

public extension Traversal1 {
	func get(_ s: S) -> A? {
		self._get(s)
	}
	
	func set(_ s: S, value: B) -> T? {
		self.update(const(value), s)
	}
	
	func update(
		_ f: @escaping (A) -> B, _ s: S
	) -> T? {
		self._update(f)(s)
	}
}

public extension Traversal1 where S == T, A == B {
	func set_(_ s: S, value: A) -> S {
		self.set(s, value: value) ?? s
	}
}
