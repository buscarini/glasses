//import UIKit
//
//struct RegularUserType {
//	var code: Int
//}
//
//struct AdvancedUserType {
//	var pass: String
//}
//
//enum UserType {
//	case regular(RegularUserType)
//	case advanced(AdvancedUserType)
//}
//
//struct User {
//	var name: String
//	var type: UserType
//}
//
//
////let userName = Optics {
////	\User.name
////}
////
////var john = User(name: "John")
////
////userName.get(john)
////
////userName.set(&john, newValue: "Anthony")
//
//struct Phone {
//	var number: Int?
//}
//
//let phoneNumber = Many {
//	\Phone.number
//	Int?.optic()
//}
//
//var phone = Phone(number: 1234)
//var phoneNone = Phone(number: nil)
//
//phoneNumber.getAll(phone)
//phoneNumber.getAll(phoneNone)
//
//phoneNumber.setAll(&phone, 12)
//
//phone
//
//phoneNumber.setAll(&phoneNone, 25)
//
//phoneNone
//
//struct Group {
//	var users: [User]?
//	var admin: User
//}
//
//var group = Group(
//	users: [
//		.init(name: "John", type: .regular(.init(code: 1))),
//		.init(name: "Anthony", type: .advanced(.init(pass: "ant")))
//	],
//	admin: .init(name: "Harvey", type: .regular(.init(code: 7)))
//)
//
////let userNames = ArrayOptics {
////	\User.name
////}
//
//let groupUsers = Many {
//	\Group.users
//	[User]?.optic()
//}
//
//print(
//	groupUsers.getAll(group)
//)
//
//
//let groupUserNames = Many {
//	\Group.users
//	[User]?.optic()
//	[User].optic()
//	\User.name
//}
//
////let names = Concat {
//////	groupUserNames
////	ArrayOptics {
////		\Group.users
////		[User]?.optic()
////		[User].optic()
////		\User.name
////	}
////
////	ArrayOptics {
////		\Group.admin.name
////	}
////}
//
//let names = Many {
//	Concat {
//		Many {
//			\Group.users
//			[User]?.optic()
//			[User].optic()
//		}
//		
//		Many {
//			\Group.admin
//		}
//	}
//	
//	\User.name
//}
//
//
//dump(
//	names.getAll(group)
//)
//
//names.updateAll(&group) { name in
//	name = name.uppercased()
//}
//
//print(group)
//
////names.setAll(&group) { "Mike" }
//
//print(group)
//
//
//let codes = Many {
//	Concat {
//		Many {
//			\Group.users
//			[User]?.optic()
//			[User].optic()
//		}
//		
//		Many {
//			\Group.admin
//		}
//	}
//	
//	\User.type
//	
//	CasePath.init(UserType.regular)
////	(/UserType.regular)
//	
//	\RegularUserType.code
//}
//
//print(
//	codes.getAll(group)
//)
//
//codes.updateAll(&group) { code in
//	code *= 2
//}
//
//print(
//	group
//)
//
//let codes2 = Many {
//	Concat {
//		Many {
//			\Group.users
//			[User]?.optic()
//			[User].optic()
//		}
//		
//		Many {
//			\Group.admin
//		}
//	} where: {
//		$0.name.lowercased().contains("o")
//	}
//	
//	\User.type
//	
//	CasePath.init(UserType.regular)
////	(/UserType.regular)
//	
//	\RegularUserType.code
//}
//
//
//print("")
//
//print(group)
//
//codes2.getAll(group)
//
//var dic = [
//	"key1": 1,
//	"key2": 17,
//	"key3": 24
//]
//
//let values = Many {
//	[String: Int].valuesOptic()
//}
//
//print(
//	values.getAll(dic)
//)
//
//
//values.updateAll(&dic, { value in
//	value *= 4
//})
//
//print(dic)
//
//
//
//extension Group {
//	static var regularUserCodes: some ArrayOptic<Self, Int> {
//		Many {
//			Concat {
//				Many {
//					\Group.users
//					[User]?.optic()
//					[User].optic()
//				}
////				.reversed
//				
//				Many {
//					\Group.admin
//				}
//			}
//			
//			\User.type
//			
//			CasePath.init(UserType.regular)
//			
//			\RegularUserType.code
//		}
//	}
//}
//
//Group.regularUserCodes.getAll(group)
//
////let firstRegularCode = First {
////	Group.regularUserCodes
////}
////
////firstRegularCode.get(group)
//
//
//
//Group.regularUserCodes.first.tryGet(group)
//
//
//Group.regularUserCodes.first.tryUpdate(&group) { $0 *= 3 }
//
//Group.regularUserCodes.getAll(group)
//
//Group.regularUserCodes.at(1).tryUpdate(&group) { $0 *= 10 }
//
//Group.regularUserCodes.getAll(group)
//
//Group.regularUserCodes.reversed.getAll(group)
//
//Group.regularUserCodes.reversed.last.tryUpdate(&group) { $0 *= 10 }
//
//Group.regularUserCodes.reversed.getAll(group)
//
//enum DataLoad {
//	case ready
//	case loading
//	case loaded(Group?)
//}
//
//var data = DataLoad.loaded(group)
//
//let loadedCasePath = /DataLoad.loaded
//
//let loaded: any ArrayOptic<DataLoad, Int> = Many {
//	loadedCasePath
//	
//	Group?.optic()
//	
//	Group.regularUserCodes
//}
//
//loaded.getAll(data)
//
//
//
////let optionalCodes = Many {
////	Group?.optic()
////	Group.regularUserCodes
////}
//
////optionalCodes.get(group)
//
//
////let loadedRegularUserCodes = Many {
////	CasePath.init(DataLoad.loaded)
////
////	Group.regularUserCodes
////}
////
////loadedRegularUserCodes.get(data)
//
