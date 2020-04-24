//
//  Traversal+Tuple.swift
//  glasses
//
//  Created by José Manuel Sánchez Peñarroja on 10/5/18.
//

import Foundation

public func both<A, B> () -> Traversal<(A, A), A, B, (B, B)> {
	Traversal(get: { s in
		[s.0, s.1]
	}, update: { f in
		{ s in
			(f(s.0), f(s.1))
		}
	})
}

public func each<A, B> () -> Traversal<(A, A), A, B, (B, B)> {
	both()
}

public func each3<A, B> () -> Traversal<(A, A, A), A, B, (B, B, B)> {
	Traversal(
		get: { s in
			[s.0, s.1, s.2]
		},
		update: { f in
			{ s in
				(f(s.0), f(s.1), f(s.2))
			}
		}
	)
}

public func each4<A, B> () -> Traversal<(A, A, A, A), A, B, (B, B, B, B)> {
	Traversal(
		get: { s in
			[s.0, s.1, s.2, s.3]
		},
		update: { f in
			{ s in
				(f(s.0), f(s.1), f(s.2), f(s.3))
			}
		}
	)
}


