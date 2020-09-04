//
//  Prism+As.swift
//  glasses
//
//  Created by José Manuel Sánchez Peñarroja on 2/8/18.
//

import Foundation

public func `as`<A, B>(_ bType: B.Type) -> SimpleTraversal1<A, B> {
	.init(
		get: { a in
			a as? B
		},
		update: { f in
			{ a in
				guard let b = a as? B else {
					return nil
				}
				
				return (f(b) as? A) ?? a
			}
		}
	)
}
