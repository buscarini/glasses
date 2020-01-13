//
//  Prism+Optional.swift
//  glasses
//
//  Created by José Manuel Sánchez Peñarroja on 17/11/17.
//

import Foundation

public func _some<A, B> () -> Prism<A?, A, B, B?> {
	return Prism(get: { s in
		return s
	}, update: { (f: @escaping ((A) -> B)) -> (A?) -> B? in
		{ s in
			return s.map(f)
		}
	})
}

