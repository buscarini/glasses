//
//  MLens+Constructor.swift
//  glasses
//
//  Created by José Manuel Sánchez Peñarroja on 29/6/18.
//

import Foundation

extension WritableKeyPath {
	public var mlens: MLens<Root, Value> {
		return mprop(self)
	}
}
