//
//  Iso.swift
//  glasses-iOS
//
//  Created by José Manuel Sánchez Peñarroja on 13/01/2020.
//  Copyright © 2020 glasses. All rights reserved.
//

import Foundation

public struct Iso<S, A> {
	let _from: (A) -> S
	let _to: (S) -> A
	
	public init(
		from: @escaping (A) -> S,
		to: @escaping (S) -> A
	) {
		self._from = from
		self._to = to
	}
	
	public var reversed: Iso<A, S> {
		return .init(from: _to, to: _from)
	}
}

public typealias SimpleIso<A> = Iso<A, A>

public func get<S, A>(_ iso: Iso<S, A>, _ s: S) -> A {
	iso._to(s)
}

public func get<S, A>(_ iso: Iso<S, A>) -> (_ s: S) -> A {
	{ s in
		get(iso, s)
	}
}

public func update<S, A>(
	_ iso: Iso<S, A>,
	_ f: @escaping (A) -> A,
	_ s: S
) -> S {
	let a = iso._to(s)
	let updated = f(a)
	return iso._from(updated)
}

public func update<S, A>(
	_ iso: Iso<S, A>,
	_ f: @escaping (A) -> A
) -> (_ s: S) -> S {
	{ s in
		update(iso, f, s)	
	}
}

public func set<S, A>(
	_ iso: Iso<S, A>,
	_ value: A,
	_ s: S
) -> S {
	update(iso, const(value), s)
}

public func set<S, A>(
	_ iso: Iso<S, A>,
	_ value: A
) -> (S) -> S {
	{ s in
		update(iso, const(value), s)
	}
}
