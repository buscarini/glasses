//
//  Array+Monoid.swift
//  TYRSharedUtils
//
//  Created by José Manuel Sánchez Peñarroja on 05/12/2018.
//  Copyright © 2018 Tyris. All rights reserved.
//

import Foundation

public extension Array {
	func reduced(_ m: Monoid<Element?>) -> Element? {
		self.reduce(nil, m.combine)
	}
	
	func reduced(_ m: Monoid<Element>) -> Element {
		self.reduce(m.empty, m.semigroup.combine)
	}
	
	func reduced<T>(
		_ f: @escaping (Element) -> T,
		_ m: Monoid<T>
	) -> T {
		self.reduce(m.empty) {
			m.semigroup.combine($0, f($1))
		}
	}
	
	func foldMap<M>(
		_ m: Monoid<M>,
		_ f: @escaping (Element) -> M
	) -> M {
		self.reduce(m.empty, { acc, item in
			m.combine(acc, f(item))
		})
	}
}
