//
//  Prism+As.swift
//  glasses
//
//  Created by José Manuel Sánchez Peñarroja on 2/8/18.
//

import Foundation

public func _as<A, B>(_ bType: B.Type) -> SimplePrism<A, B> {
	return SimplePrism<A, B>(get: {
		return $0 as? B
	}, update: { f in
		{ a in
			guard let b = a as? B else {
				return a
			}
			
			return (f(b) as? A) ?? a
		}
	})
}
