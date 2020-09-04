//
//  Lens+Tuple.swift
//  glasses
//
//  Created by José Manuel Sánchez Peñarroja on 26/10/17.
//

import Foundation

// MARK: Tuple-2
public func _0<A, B, W> () -> Lens<(A, W), A, B, (B, W)> {
	return Lens(get: { s in
		return s.0
	}, update: { f in
		{ s in
			let (a, w) = s
			return (f(a), w)
		}
	})
}

public func _1<A, B, W>() -> Lens<(W, A), A, B, (W, B)> {
	return Lens(get: { s in
		return s.1
	}, update: { f in
		{ s in
			let (w, a) = s
			return (w, f(a))
		}
	})
}

// MARK: Tuple-3
public func _0<A, B, C, W> () -> Lens<(A, B, W), A, C, (C, B, W)> {
	return Lens(get: { s in
		return s.0
	}, update: { f in
		{ s in
			let (a, b, w) = s
			return (f(a), b, w)
		}
	})
}

public func _1<A, B, C, W> () -> Lens<(W, A, B), A, C, (W, C, B)> {
	return Lens(get: { s in
		return s.1
	}, update: { f in
		{ s in
			let (w, a, b) = s
			return (w, f(a), b)
		}
	})
}

public func _2<A, B, C, W> () -> Lens<(W, B, A), A, C, (W, B, C)> {
	return Lens(get: { s in
		return s.2
	}, update: { f in
		{ s in
			let (w, b, a) = s
			return (w, b, f(a))
		}
	})
}

