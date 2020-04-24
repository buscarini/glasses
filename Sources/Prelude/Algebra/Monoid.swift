//
//  Monoid.swift
//  TYRSharedUtils
//
//  Created by José Manuel Sánchez Peñarroja on 05/12/2018.
//  Copyright © 2018 Tyris. All rights reserved.
//

import Foundation

public struct Monoid<T> {
	public var empty: T
	public var semigroup: Semigroup<T>
	
	public var combine: (T, T) -> T {
		return semigroup.combine
	}
	
	public init(empty: T, semigroup: Semigroup<T>) {
		self.empty = empty
		self.semigroup = semigroup
	}
	
	public init(empty: T, combine: @escaping (T, T) -> T) {
		self.init(empty: empty, semigroup: Semigroup<T>.init(combine: combine))
	}
}
