//
//  Traversal+Tuple.swift
//  glasses
//
//  Created by José Manuel Sánchez Peñarroja on 10/5/18.
//

import Foundation

public func _both<A, B> () -> Traversal<(A, A), A, B, (B, B)> {
	return Traversal(get: { s in
		return [s.0, s.1]
	}, update: { f in
		{ s in
			return (f(s.0), f(s.1))
		}
	})
}
