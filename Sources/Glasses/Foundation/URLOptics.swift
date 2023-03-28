import Foundation

extension URL {
	public static func componentsOptic(
		resolvingAgainstBaseURL: Bool = true
	) -> some SimpleOptionalOptic<URL, URLComponents> {
		OptionalRawOptic { url in
			URLComponents(url: url, resolvingAgainstBaseURL: resolvingAgainstBaseURL)
		} tryUpdate: { url, update in
			guard
				var components = URLComponents(
					url: url,
					resolvingAgainstBaseURL: resolvingAgainstBaseURL
				)
			else {
				return url
			}
			
			components = update(components)
			return components.url ?? url
		} trySet: { url, newComponents in
			newComponents.url ?? url
		}
	}
	
	public static func schemeOptic(
		resolvingAgainstBaseURL: Bool = true
	) -> some SimpleOptionalOptic<URL, String> {
		Optionally {
			self.componentsOptic(resolvingAgainstBaseURL: resolvingAgainstBaseURL)
			\URLComponents.scheme
			String?.optic()
		}
	}
	
	public static func hostOptic(
		resolvingAgainstBaseURL: Bool = true
	) -> some SimpleOptionalOptic<URL, String> {
		Optionally {
			self.componentsOptic(resolvingAgainstBaseURL: resolvingAgainstBaseURL)
			\URLComponents.host
			String?.optic()
		}
	}
}
