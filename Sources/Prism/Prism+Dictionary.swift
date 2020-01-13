//
//  Prism+Dictionary.swift
//  glasses
//
//  Created by José Manuel Sánchez Peñarroja on 10/5/18.
//

import Foundation

public func _value<K: Hashable, A>(key: K) -> SimplePrism<[K: A], A> {
	return SimplePrism<[K: A], A>(get: { s in
		return s[key]
	}, update: { f in
		{ s in
			var copy = s
			copy[key] = copy[key].map(f)
			return copy
		}
	})
}
