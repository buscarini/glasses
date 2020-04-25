//
//  Prism+Optional.swift
//  glasses
//
//  Created by José Manuel Sánchez Peñarroja on 17/11/17.
//

import Foundation

public func some<A, B> () -> Prism<A?, A, B, B?> {
	.init(embed: id, extract: id)
}

