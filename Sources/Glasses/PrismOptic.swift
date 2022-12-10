import Foundation
import CasePaths

public protocol PrismOptic<Whole, Part> {
	associatedtype Whole
	associatedtype Part
		
	func extract(from whole: Whole) -> Part?
	
	func embed(_ part: Part) -> Whole
}

extension CasePath: PrismOptic {}
