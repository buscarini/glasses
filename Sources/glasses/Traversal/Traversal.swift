//
//  Traversal.swift
//  glasses
//
//  Created by José Manuel Sánchez Peñarroja on 25/10/17.
//

import Foundation

public struct Traversal<S, A, B, T> {
	let _get: (S) -> [A]
	let _update: (@escaping (A) -> B) -> (S) -> T
	
	public init(
		get: @escaping (S) -> [A],
		update: @escaping (@escaping (A) -> B
	) -> (S) -> T) {
		self._get = get
		self._update = update
	}
}

public typealias SimpleTraversal<S, A> = Traversal<S, A, A, S>

@inlinable
public func get<S, A, B, T>(_ t: Traversal<S, A, B, T>, _ s: S) -> [A] {
	get(t)(s)
}

@inlinable
public func get<S, A>(_ t: SimpleTraversal<S, A>, _ s: S) -> [A] {
	get(t)(s)
}

public func get<S, A, B, T>(_ t: Traversal<S, A, B, T>) -> (_ s: S) -> [A] {
	{ s in
		t._get(s)
	}
}

public func get<S, A>(_ t: SimpleTraversal<S, A>) -> (_ s: S) -> [A] {
	{ s in
		t._get(s)
	}
}

@inlinable
public func update<S, A, B, T>(
	_ t: Traversal<S, A, B, T>,
	_ f: @escaping (A) -> B,
	_ s: S
) -> T {
	update(t, f)(s)
}

public func update<S, A, B, T>(
	_ t: Traversal<S, A, B, T>,
	_ f: @escaping (A) -> B
) -> (_ s: S) -> T {
	{ t._update(f)($0) }
}

//public func set<S, A, B, T>(
//	_ t: Traversal<S, A, B, T>,
//	_ b: [B],
//	_ s: S
//) -> T {
//	t._update(const(b))(s)
//}

public func set<S, A, B, T>(
	_ t: Traversal<S, A, B, T>,
	_ b: B
) -> (_ s: S) -> T {
	{ $0
		|> t._update(const(b))
	}
}

public func set<S, A, B, T>(
	_ t: Traversal<S, A, B, T>
) -> (_ b: B) -> (_ s: S) -> T {
	{ b in
		{ $0
			|> t._update(const(b))
		}
	}
}


//public func map<S: Sequence, B>(_ f: @escaping (S.Element) -> B) -> Traversal<S, S.Element, B> {
//	return Traversal(get: { (s: S) -> [S.Element] in
//		return s.map(id)
//		}, update: { (f: @escaping ((S.Element) -> B)) -> (S) -> [B] in
//			{ (s: S) -> [B] in
//				return s.map(f)
//			}
//		})
//}


//func map<A, B> (_ f: @escaping (A) -> B) -> Lens<[A], A, B, [B]> {
//	return Lens(get: { $0. }, update: )
//}
