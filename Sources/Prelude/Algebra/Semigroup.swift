//
//  Semigroup.swift
//  TYRSharedUtils
//
//  Created by José Manuel Sánchez Peñarroja on 05/12/2018.
//  Copyright © 2018 Tyris. All rights reserved.
//

import Foundation

public struct Semigroup<T> {
	public var combine: (T, T) -> T
	
	public init(combine: @escaping (T, T) -> T) {
		self.combine = combine
	}
	
	public func lift() -> Monoid<T?> {
		return Monoid<T?>.init(empty: nil) { left, right in
			guard let left = left else {
				return right
			}
			
			guard let right = right else {
				return left
			}
			
			return self.combine(left, right)
		}
	}
}

