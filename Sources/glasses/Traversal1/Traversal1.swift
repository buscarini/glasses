//
//  Traversal1.swift
//  glasses-iOS
//
//  Created by José Manuel Sánchez Peñarroja on 25/04/2020.
//  Copyright © 2020 glasses. All rights reserved.
//

import Foundation

public struct Traversal1<S, A, B, T> {
	let _get: (S) -> A?
	let _update: (@escaping (A) -> B) -> (S) -> T?
	
	public init(
		get: @escaping (S) -> A?,
		update: @escaping (@escaping (A) -> B) -> (S) -> T?
	) {
		self._get = get
		self._update = update
	}
}

public typealias SimpleTraversal1<S, A> = Traversal1<S, A, A, S>

public func get<S, A, B, T>(_ t: Traversal1<S, A, B, T>, _ s: S) -> A? {
	t._get(s)
}

public func get<S, A>(_ t: SimpleTraversal1<S, A>, _ s: S) -> A? {
	t._get(s)
}

public func get<S, A, B, T>(_ t: Traversal1<S, A, B, T>) -> (_ s: S) -> A? {
	t._get
}

public func get<S, A>(_ t: SimpleTraversal1<S, A>) -> (_ s: S) -> A? {
	t._get
}

public func update<S, A, B, T>(
	_ t: Traversal1<S, A, B, T>,
	_ f: @escaping (A) -> B,
	_ s: S
) -> T? {
	t._update(f)(s)
}

public func update<S, A, B, T>(
	_ t: Traversal1<S, A, B, T>,
	_ f: @escaping (A) -> B
) -> (_ s: S) -> T? {
	t._update(f)
}

public func set<S, A, B, T>(
	_ t: Traversal1<S, A, B, T>,
	_ b: B,
	_ s: S
) -> T? {
	t._update(const(b))(s)
}

public func set<S, A, B, T>(
	_ t: Traversal1<S, A, B, T>,
	_ b: B
) -> (_ s: S) -> T? {
	t._update(const(b))
}

public func set_<S, A>(
	_ t: SimpleTraversal1<S, A>,
	_ a: A,
	_ s: S
) -> S {
	t._update(const(a))(s) ?? s
}

public func set_<S, A>(
	_ t: SimpleTraversal1<S, A>,
	_ a: A
) -> (_ s: S) -> S {
	{ s in
		set_(t, a, s)
	}
}
