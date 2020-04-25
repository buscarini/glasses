//
//  Prism.swift
//  glasses
//
//  Created by José Manuel Sánchez Peñarroja on 26/10/17.
//

import Foundation


public struct Prism<S, A, B, T> {
	let _embed: (B) -> T
	let _extract: (S) -> A?
	
	public init(
		embed: @escaping (B) -> T,
		extract: @escaping (S) -> A?
	) {
		self._embed = embed
		self._extract = extract
	}
}

public typealias SimplePrism<S, A> = Prism<S, A, A, S>

public func extract<S, A, B, T>(_ prism: Prism<S, A, B, T>, _ s: S) -> A? {
	prism._extract(s)
}

public func extract<S, A, B, T>(_ prism: Prism<S, A, B, T>) -> (_ s: S) -> A? {
	{ s in
		prism._extract(s)
	}
}

public func update<S, A, B, T>(
	_ prism: Prism<S, A, B, T>,
	_ f: @escaping (A) -> B,
	_ s: S
) -> T? {
	guard let a = prism._extract(s) else {
		return nil
	}
	
	return prism._embed(f(a))
}

public func update<S, A, B, T>(
	_ prism: Prism<S, A, B, T>,
	_ f: @escaping (A) -> B
) -> (_ s: S) -> T? {
	{ s in
		update(prism, f, s)
	}
}

public func embed<S, A, B, T>(
	_ prism: Prism<S, A, B, T>,
	_ b: B
) -> T {
	prism._embed(b)
}

public func embed<S, A, B, T>(
	_ prism: Prism<S, A, B, T>
) -> (_ b: B) -> T? {
	{ b in
		prism._embed(b)
	}
}

