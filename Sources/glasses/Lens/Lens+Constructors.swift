//
//  Lens+Constructors.swift
//  glasses
//
//  Created by José Manuel Sánchez Peñarroja on 22/11/17.
//

import Foundation

extension WritableKeyPath {
	public var lens: Lens<Root, Value, Value, Root> {
		return prop(self)
	}
}
