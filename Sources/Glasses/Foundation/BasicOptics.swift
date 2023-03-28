import Foundation
import CasePaths

extension Array {
	public static func optic<NewElement>() -> ArrayDefaultOptic<Element, NewElement> {
		.init()
	}
}

extension Dictionary {
	public static func valuesOptic<NewValue>() -> DictionaryValuesOptic<Key, Value, NewValue> {
		.init()
	}
}

extension Optional {
	public static func optic() -> PrismOptionalOptic<Wrapped> {
		.init()
	}
}

extension Result {
	public static func optic() -> CasePath<Result, Success> {
		/Result.success
	}
}

