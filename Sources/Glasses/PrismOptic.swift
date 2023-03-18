import Foundation
import CasePaths

public protocol PrismOptic<Whole, Part> {
	associatedtype Whole
	associatedtype Part
		
	func extract(from whole: Whole) -> Part?
	
	func embed(_ part: Part) -> Whole
}

extension PrismOptic {
	func tryUpdate(
		_ whole: inout Whole,
		_ f: @escaping (inout Part) -> Void
	) {
		guard var part = extract(from: whole) else {
			return
		}
		
		f(&part)
		
		whole = embed(part)
	}
	
	func trySet(
		_ whole: inout Whole,
		to newValue: Part
	) {
		self.tryUpdate(&whole) { part in
			part = newValue
		}
	}
}

extension CasePath: PrismOptic {}

public struct PrismOptionalOptic<Wrapped>: PrismOptic {
	public typealias Whole = Optional<Wrapped>
	public typealias Part = Wrapped

	public func embed(_ part: Wrapped) -> Optional<Wrapped> {
		.some(part)
	}
	
	public func extract(from whole: Optional<Wrapped>) -> Wrapped? {
		whole
	}
}
