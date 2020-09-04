//
//  Prism+Dictionary.swift
//  glasses
//
//  Created by José Manuel Sánchez Peñarroja on 10/5/18.
//

import Foundation

public extension Dictionary {
	static func _value<K: Hashable, A>(
		key: K
	) -> SimpleTraversal1<[K: A], A> {
		.init(get: { s in
			s[key]
		}, update: { f in
			{ s in
				var copy = s
				copy[key] = copy[key].map(f)
				return copy
			}
		})
	}
}
