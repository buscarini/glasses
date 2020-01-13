//
//  Prelude.swift
//  glasses-iOS
//
//  Created by José Manuel Sánchez Peñarroja on 13/01/2020.
//  Copyright © 2020 glasses. All rights reserved.
//

import Foundation

@inlinable
public func id<a>(_ a: a) -> a {
	a
}

@inlinable
public func absurd<A>(_ n: Never) -> A {}

@inlinable
public func discard<A>(_ value: A) -> Void {	}

@inlinable
public func const<A, B>(_ b: B) -> (_ a: A) -> B {
	{ _ in b }
}
