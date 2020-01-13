//
//  Getter.swift
//  glasses
//
//  Created by José Manuel Sánchez Peñarroja on 9/11/17.
//

import Foundation

public protocol Getter {
	associatedtype Root
	associatedtype Value
	func get(_ s: Root) -> Value
}

public func view<G: Getter>(_ g: G) -> (G.Root) -> G.Value {
	return { s in
		return g.get(s)
	}
}
