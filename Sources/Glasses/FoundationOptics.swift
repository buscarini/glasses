import Foundation
import CasePaths

extension Array {
	public static func optic() -> ArrayDefaultOptic<Element> {
		.init()
	}
}

extension Dictionary {
	public static func valuesOptic() -> DictionaryValuesOptic<Key, Value> {
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

