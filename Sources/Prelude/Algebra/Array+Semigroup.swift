//
//  Array+Semigroup.swift
//  glasses-iOS
//
//  Created by José Manuel Sánchez Peñarroja on 25/04/2020.
//  Copyright © 2020 glasses. All rights reserved.
//

import Foundation

public extension Array {
	func reduced(_ initial: Element, _ s: Semigroup<Element>) -> Element {
		self.reduce(initial, s.combine)
	}
	
	func reduced(_ s: Semigroup<Element>) -> Element? {
		self.reduce(nil, { acc, item in
			guard let acc = acc else {
				return item
			}
			
			return s.combine(acc, item)
		})
	}
	
	func foldMap<S>(
		_ s: Semigroup<S>,
		_ f: @escaping (Element) -> S
	) -> S? {
		self.map(f).reduced(s)
	}
}
