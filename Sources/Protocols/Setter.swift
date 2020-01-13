//
//  Setter.swift
//  glasses
//
//  Created by José Manuel Sánchez Peñarroja on 11/4/18.
//

import Foundation

public protocol Setter {
	associatedtype SetterRoot
	associatedtype SetterValue
	associatedtype SetterNewRoot
	func set(_ s: SetterRoot, value: SetterValue) -> SetterNewRoot
}
