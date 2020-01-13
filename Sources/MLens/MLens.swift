//
//  MLens.swift
//  glasses
//
//  Created by José Manuel Sánchez Peñarroja on 29/6/18.
//

import Foundation


public struct MLens<S, A> {
    let _get: (S) -> A
    let _update: (@escaping (inout A) -> Void) -> (inout S) -> Void

    public init(get: @escaping (S) -> A, update: @escaping (@escaping (inout A) -> Void) -> (inout S) -> Void) {
        self._get = get
        self._update = update
    }
}

public func get<S, A>(_ lens: MLens<S, A>, _ s: S) -> A {
    return lens._get(s)
}

public func mupdate<S, A>(_ lens: MLens<S, A>, _ f: @escaping (inout A) -> Void, _ s: inout S) -> Void {
    lens._update(f)(&s)
}

public func mset<S, A>(_ lens: MLens<S, A>, _ a: A) -> (inout S) -> Void {
	return { s in
		lens._update({ old in
			old = a
		})(&s)
	}
}

public func mprop<S, A>(_ keyPath: WritableKeyPath<S, A>)
	-> MLens<S, A> {
	return MLens<S, A>(get: { (s: S) -> A in
		return s[keyPath: keyPath]
	}, update: { (f: @escaping ((inout A) -> Void)) -> (inout S) -> Void in
		return { s in
			var a = s[keyPath: keyPath]
			f(&a)
			s[keyPath: keyPath] = a
		}
	})
}
