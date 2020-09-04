//
//  MSetters.swift
//  glasses
//
//  Created by José Manuel Sánchez Peñarroja on 29/6/18.
//

import Foundation

public func mset<S, A>(_ path: WritableKeyPath<S, A>, _ a: A) -> (inout S) -> Void {
	return { s in
		s[keyPath: path] = a
	}
}

public func mupdate<S, A>(_ path: WritableKeyPath<S, A>, _ f: @escaping (inout A) -> Void) -> (inout S) -> Void {
	return { s in
		var a = s[keyPath: path]
		f(&a)
		s[keyPath: path] = a
	}
}

public func mupdate<S, A>(_ path: WritableKeyPath<S, A>, _ f: @escaping (A) -> A) -> (inout S) -> Void {
	return { s in
		s[keyPath: path] = f(s[keyPath: path])
	}
}


public func mupdate<S: AnyObject, A>(
  _ setter: (@escaping (inout A) -> Void) -> (S) -> Void,
  _ f: @escaping (inout A) -> Void
  )
  -> (S) -> Void {

    return setter(f)
}


public func mupdate<S: AnyObject, A>(
  _ path: ReferenceWritableKeyPath<S, A>,
  _ f: @escaping (inout A) -> Void
  )
  -> (S) -> Void {
	return { s in
		f(&s[keyPath: path])
	}
}

public func mset<S: AnyObject, A>(
  _ setter: (@escaping (inout A) -> Void) -> (S) -> Void,
  _ value: A
  )
  -> (S) -> Void {

    return mupdate(setter) { $0 = value }
}

public func mset<S: AnyObject, A>(
  _ path: ReferenceWritableKeyPath<S, A>,
  _ a: A
  )
  -> (S) -> Void {
	return { s in
		s[keyPath: path] = a
	}
}
