//
//  Lens.swift
//  glasses
//
//  Created by José Manuel Sánchez Peñarroja on 24/10/17.
//

import Foundation

public struct Lens<S, A, B, T> {
	let _get: (S) -> A
	let _update: (@escaping (A) -> B) -> (S) -> T
	
	public init(get: @escaping (S) -> A, update: @escaping (@escaping (A) -> B) -> (S) -> T) {
		self._get = get
		self._update = update
	}
}

public typealias SimpleLens<S, A> = Lens<S, A, A, S>

public func get<S, A>(_ lens: Lens<S, A, A, S>, _ s: S) -> A {
	lens._get(s)
}

public func get<S, A>(_ lens: Lens<S, A, A, S>) -> (_ s: S) -> A {
	lens._get
}

public func get<S, A>(_ path: KeyPath<S, A>) -> (_ s: S) -> A {
	{ s in
		s[keyPath: path]
	}
}

public func update<S, A, B, T>(_ lens: Lens<S, A, B, T>, _ f: @escaping (A) -> B, _ s: S) -> T {
	lens._update(f)(s)
}

public func update<S, A, B, T>(_ lens: Lens<S, A, B, T>, _ f: @escaping (A) -> B) -> (_ s: S) -> T {
	lens._update(f)
}

public func update<S, A>(_ path: WritableKeyPath<S, A>, _ f: @escaping (A) -> A) -> (_ s: S) -> S {
	{
		var result = $0
		result[keyPath: path] = f(result[keyPath: path])
		return result
	}
}

public func set<S, A, B, T>(_ lens: Lens<S, A, B, T>, _ b: B, _ s: S) -> T {
	lens._update(const(b))(s)
}

public func set<S, A, B, T>(_ lens: Lens<S, A, B, T>, _ b: B) -> (_ s: S) -> T {
	lens._update(const(b))
}

public func set<S, A>(_ path: WritableKeyPath<S, A>, _ a: A) -> (_ s: S) -> S {
	update(path, const(a))
}

public func prop<S, A>(_ keyPath: WritableKeyPath<S, A>)
	-> Lens<S, A, A, S> {
		Lens<S, A, A, S>(get: { (s: S) -> A in
			s[keyPath: keyPath]
		}, update: { (f: @escaping ((A) -> A)) -> (S) -> S in
			{ s in
				var copy = s
				copy[keyPath: keyPath] = f(copy[keyPath: keyPath])
				return copy
			}
		})
}






//func map<A, B> (_ f: @escaping (A) -> B) -> Lens<[A], A, B, [B]> {
//	return Lens(get: { $0. }, update: )
//}
//
//
//func map<A, B> (_ f: @escaping (A) -> B) -> ([A]) -> [B] {
//	return { $0.map(f) }
//}
//
//func map<A, B> (_ f: @escaping (A) -> B) -> (A?) -> B? {
//	return { $0.map(f) }
//}



