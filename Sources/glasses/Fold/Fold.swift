//
//  Fold.swift
//  glasses-iOS Tests
//
//  Created by José Manuel Sánchez Peñarroja on 24/04/2020.
//  Copyright © 2020 glasses. All rights reserved.
//

import Foundation

public struct Fold<S, A> {
	let _get: (S) -> [A]
	
	public init(get: @escaping (S) -> [A]) {
		self._get = get
	}
}

@inlinable
public func get<S, A>(_ f: Fold<S, A>, _ s: S) -> [A] {
	get(f)(s)
}

public func get<S, A>(_ f: Fold<S, A>) -> (_ s: S) -> [A] {
	{ s in
		f._get(s)
	}
}
