//
//  Prism+Getter.swift
//  glasses
//
//  Created by José Manuel Sánchez Peñarroja on 11/4/18.
//

import Foundation

extension Prism: Getter {
	public typealias Root = S
	public typealias Value = A?
	
	public func get(_ s: S) -> A? {
		self._extract(s)
	}
}
