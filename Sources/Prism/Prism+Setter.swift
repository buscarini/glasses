//
//  Prism+Setter.swift
//  glasses
//
//  Created by José Manuel Sánchez Peñarroja on 11/4/18.
//

import Foundation

extension Prism: Setter {
	public typealias SetterRoot = S
	public typealias SetterValue = B
	public typealias SetterNewRoot = T?
}
