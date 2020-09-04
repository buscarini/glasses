//
//  Fold+Utils.swift
//  glasses-iOS
//
//  Created by José Manuel Sánchez Peñarroja on 25/04/2020.
//  Copyright © 2020 glasses. All rights reserved.
//

import Foundation
import Algebraic

public extension Fold where A: Equatable {
	func contains(
		_ a: A,
		_ s: S
	) -> Bool {
		self._get(s).contains(a)
	}
}

public extension Fold {
	func count(_ s: S) -> Int {
		self.get(s).count
	}
	
	func any(
		_ pred: @escaping (A) -> Bool,
		_ s: S
	) -> Bool {
		self.map(pred).reduced(Monoid.any, s)
	}
	
	func all(
		_ pred: @escaping (A) -> Bool,
		_ s: S
	) -> Bool {
		self.map(pred).reduced(Monoid.all, s)
	}
}
